# frozen_string_literal: true

module Queen
  # A registry for all rules
  #
  # The storage is a key value store with the rule name
  # as the key and the rule object as the value
  #
  # @api private
  class RuleRegistry
    def initialize
      @rules = {}
    end

    # Register a new rule with the registry
    #
    # @param [String] name
    # @param [Queen::Rule] rule
    #
    # @api public
    def set(name, rule, **options)
      @rules[name] = rule
    end

    def get(name)
      @rules[name]
    end

    def each(&block)
      return to_enum unless block
      @rules.each(&block)
    end

    def length
      @rules.size
    end

    def names
      @rules.keys
    end

    def rules
      @rules.values
    end
  end # RuleRegistry
end # Queen
