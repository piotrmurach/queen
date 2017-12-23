# frozen_string_literal: true

module Queen
  # A registry for all rules
  class RuleRegistry
    def initialize
      @rules = {}
    end

    def set(name, rule, **options)
      @rules[name] = rule
    end

    def get(name)
      @rules[name]
    end

    def each(&block)
      return to_enum unless block
      rules.each(&block)
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
