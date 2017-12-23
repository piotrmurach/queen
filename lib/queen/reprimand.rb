# frozen_string_literal: true

module Queen
  # Represents a language issue found by Courtier
  class Reprimand
    attr_reader :line

    attr_reader :column

    attr_reader :message

    def initialize(line, column, message)
      @line    = line
      @column  = column
      @message = message.freeze
      freeze
    end

    def self.[](line, column, message)
      new(line, column, message)
    end

    # Compose a GNU style string representation
    #
    # @return [String]
    #
    # @api private
    def to_s
      "%d:%d: %s" % [line + 1, column + 1, message]
    end
  end # Reprimand
end # Queen
