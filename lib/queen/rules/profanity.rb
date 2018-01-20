# frozen_string_literal: true

require 'yaml'

require_relative '../rule'

module Queen
  module Rules
    class Profanity < Queen::Rule

      register 'profanity', Profanity

      # The Regexp to use for scanning in words.
      WORD_REGEXP = /[^\W_][\w'-]*[^\W_]/

      MSG = "%s might be viewed as profane. Consider removing this word."

      def initialize(**options)
        super
        file_path = ::File.join(__dir__, 'profanities.yml')
        @profanities_dict = YAML.load_file(file_path)
      end

      def check(source)
        source.each_line.with_index do |line, lineno|
          words = split_text_to_words(line)

          words.each do |word|
            column = line.index(word)

            if @profanities_dict.include?(word.downcase)
              msg = sprintf(MSG, pastel.yellow(word))
              add_reprimand(lineno, column, msg)
            end
          end
        end
      end

      private

      def split_text_to_words(text)
        text.scan(WORD_REGEXP)
      end
    end
  end # Rules
end # Queen
