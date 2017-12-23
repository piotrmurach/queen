# frozen_string_literal: true

require 'ffi/aspell'

require_relative '../rule'

module Queen
  module Rules
    class WordSpelling < Queen::Rule

      register 'word_spelling', WordSpelling

      # The Regexp to use for scanning in words.
      WORD_REGEXP = /[^\W_][\w'-]*[^\W_]/

      # The Regexp to filter out Acronyms.
      ACRONYM_REGEXP = /(([A-Z]\.){2,}|[A-Z]{2,})/

      MSG = "%s might not be spelled correctly. Spelling suggestions: %s"

      def initialize(**options)
        super
        lang = options.fetch(:lang, 'en')
        @speller = FFI::Aspell::Speller.new(lang)
        @speller.suggestion_mode = 'fast'
      end

      def check(source)
        source.each_line.with_index do |line, lineno|
          words = split_text_to_words(line)

          words.each do |word|
            column = line.index(word)

            next if word =~ ACRONYM_REGEXP
            next if word.size < 4

            if !@speller.correct?(word)
              msg = sprintf(MSG, pastel.yellow(word), suggestions_for(word))
              add_reprimand(lineno, column, msg)
            end
          end
        end
      end

      private

      def suggestions_for(word)
        suggestions = @speller.suggestions(word)
        if suggestions.empty?
          'Nothing matches.'
        else
          suggestions[0..5].join(', ')
        end
      end

      def split_text_to_words(text)
        text.scan(WORD_REGEXP)
      end
    end # WordSpelling
  end # Rules
end # Queen
