# frozen_string_literal: true

require 'pastel'

require_relative 'reprimand'
require_relative 'rules'

module Queen
  # Base class for every rule
  class Rule
    extend Queen::Rules

    attr_reader :reprimands

    attr_reader :pastel

    def self.rule_name
      name.to_s.split('::').last
    end

    def self.rules
      rule_registry.rules
    end

    # Initializes a rule
    #
    # @api private
    def initialize(**options)
      @reprimands = []
      @pastel = Pastel.new
    end

    def add_reprimand(line, column, message)
      @reprimands << Reprimand[line, column, message]
    end

    def name
      self.class.rule_name
    end
  end # Rule
end # Queen
