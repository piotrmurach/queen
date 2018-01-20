# frozen_string_literal: true

require 'pathname'
require 'yaml'

require_relative 'config'

module Queen
  class ConfigLoader

    FILE_NAME = '.queen.yml'

    ROOT = Pathname(::File.join(__dir__, '..', '..', '..')).dirname.expand_path.freeze

    DEFAULT_PATH = ::File.join(ROOT, 'config', 'default.yml')

    # Load configuration file
    #
    # @api private
    def self.load_file(path = nil)
      file_path = DEFAULT_PATH
      hash = YAML.load_file(file_path)
      Config.coerce(hash)
    end
  end # ConfigLoader
end # Queen
