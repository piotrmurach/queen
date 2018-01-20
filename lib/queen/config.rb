# frozen_string_literal: true

module Queen
  class Config
    # Raised when an invalid rule is specified
    InvalidRule = Class.new(StandardError)

    # Coerce hash into config object
    #
    # @api private
    def self.coerce(hash, &block)
      new(normalize_hash(hash), &block)
    end

    # Convert string keys to symbols
    #
    # @api private
    def self.normalize_hash(hash)
      hash.reduce({}) do |acc, (key, val)|
        acc[key.to_sym] = val.is_a?(::Hash) ? normalize_hash(val) : val
        acc
      end
    end

    # Create a new config
    #
    # @api private
    def initialize(options = {})
      @rules = options.fetch(:rules, {})
      yield(self) if block_given?
    end

    # Return metadata for a given rule
    #
    # @param [String] rule_name
    #
    # @return [Hash]
    #
    # @api private
    def for_rule(rule_name)
      @rules.fetch(rule_name.to_sym, {})
    end
  end # Config
end # Queen
