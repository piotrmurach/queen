if ENV['COVERAGE'] || ENV['TRAVIS']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name 'spec'
    add_filter 'spec'
  end
end

require 'bundler/setup'
require 'queen'
require 'open3'

class String
  def unindent
    gsub(/^[ \t]*/, '').chomp
  end
end

module TestHelpers
  module Paths
    def gem_root
      File.expand_path("#{File.dirname(__FILE__)}/..")
    end

    def dir_path(*args)
      path = File.join(gem_root, *args)
      FileUtils.mkdir_p(path)
      File.realpath(path)
    end

    def tmp_path(*args)
      File.join(dir_path('tmp'), *args)
    end

    def fixtures_path(*args)
      File.join(dir_path('spec/fixtures'), *args)
    end

    def within_dir(target, &block)
      ::Dir.chdir(target, &block)
    end
  end

  module Silent
    def silent_run(*args)
      out = Tempfile.new('tty-cmd')
      result = system(*args, out: out.path)
      return if result
      out.rewind
      fail "#{args.join} failed:\n#{out.read}"
    end
  end
end

RSpec.configure do |config|
  config.include(TestHelpers::Paths)
  config.include(TestHelpers::Silent)
  config.after(:example, type: :cli) do
    FileUtils.rm_rf(tmp_path)
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
