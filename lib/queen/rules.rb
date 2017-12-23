# frozen_string_literal: true

require_relative 'rule_registry'

module Queen
  module Rules
    def self.extended(base)
      base.class_eval do
        @rule_registry = RuleRegistry.new
      end
    end

    attr_reader :rule_registry

    # Expose rule registry in subclasses
    #
    # @param [Class] subclass
    #   class that inherits from this class
    #
    # @api private
    def inherited(subclass)
      super
      subclass.instance_variable_set(:@rule_registry, rule_registry)
    end

    # Register a rule
    #
    # @example Register a rule
    #   module Rules
    #     extend Queen::Rules
    #
    #     class WordSpelling < Queen::Rule
    #     end
    #
    #     register "word_spelling", WordSpelling
    #   end
    #
    # @api public
    def register(name, rule, **options)
      @rule_registry.set(name, rule, **options)
    end

    def get(arguments)
      @rule_registry.get(arguments)
    end
  end
end
