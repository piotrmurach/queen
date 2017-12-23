# frozen_string_literal: true

require 'optparse'
require 'logger'

require_relative 'rule'
require_relative 'rules/word_spelling'

require_relative 'reporter'
require_relative 'version'

module Queen
  # Responsible for command line interface
  #
  # @api public
  class CLI
    # Error raised by this runner
    Error = Class.new(StandardError)

    # Convenience call
    #
    # @api public
    def self.run(*args)
      new.run(*args)
    end

    def initialize
      @option_parser = OptionParser.new { |opts| setup_options(opts) }
      @log           = ::Logger.new($stdout)
      @files         = []
    end

    def run(*args)
      @option_parser.parse!(args)

      if args.empty?
        puts @option_parser.help
        exit
      end

      args.each do |file_or_dir|
        if File.directory?(file_or_dir)
          Find.find(file_or_dir) do |path|
            @files << path
          end
        else
          @files << file_or_dir
        end
      end

      total_reprimands = 0
      reporter = Reporter.new

      puts reporter.banner(@files)

      @files.each do |file|
        source = File.read(file)

        Queen::Rule.rules.each do |rule_class|
          rule = rule_class.new
          rule.check(source)
          total_reprimands += rule.reprimands.count
          puts reporter.report(file, rule)
        end
      end

      puts
      puts reporter.summary(@files, total_reprimands)
    end

    private

    def setup_options(opts)
      opts.banner = "Usage: queen [options] FILE|DIRECTORY..."
      opts.separator ""
      opts.separator "Options"

      opts.on_tail('-q', '--quiet', 'Display no warnings.') do
        @log.level = Logger::ERROR
      end
      opts.on_tail('--verbose', 'Display more information.') do
        @log.level = Logger::INFO
      end
      opts.on_tail('--debug', 'Display debugging information.') do
        @log.level = Logger::DEBUG
      end
      opts.on_tail('-v', '--version', 'Display version.') do
        puts "queen #{Queen::VERSION}"; exit
      end
      opts.on_tail('-h', '--help', 'Display this help message.') do
        puts opts.help; exit
      end
    end

    def handle_parse_error
      yield
    rescue OptionParser::ParserError => err
      raise Error, err
    end
  end # CLI
end # Queen
