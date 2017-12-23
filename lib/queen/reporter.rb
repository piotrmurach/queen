# frozen_string_literal: true

require 'pastel'
require 'pathname'

module Queen
  class Reporter
    def initialize
      @pastel = Pastel.new
    end

    def banner(files)
      file_suffix = files.count !=1 ? 's' : ''
      "Reviewing #{files.count} file#{file_suffix}\n\n" +
      "Reprimands:\n\n"
    end

    # Generate all reprimandes gathered for a file
    #
    # @api public
    def report(file, rule)
      rule.reprimands.map do |reprimand|
        report_reprimand(file, reprimand)
      end.join("\n")
    end

    def report_reprimand(file, reprimand)
      "#{@pastel.magenta(relative_path(file))}:#{reprimand}"
    end

    def summary(files, total_reprimands)
      file_suffix = files.count != 1 ? 's' : ''
      "#{files.count} file#{file_suffix} read, " +
        reprimands_summary(total_reprimands)
    end

    def reprimands_summary(total_reprimands)
      case total_reprimands
      when 0
        @pastel.green("no reprimands")
      when 1
        @pastel.red("#{total_reprimands} reprimand")
      else
        @pastel.red("#{total_reprimands} reprimands")
      end + " given."
    end

    def relative_path(path, root_path = Dir.pwd)
      path_name = Pathname.new(path)
      if path.start_with?(root_path)
        path_name.relative_path_from(Pathname.new(root_path)).to_s
      else
        path
      end
    end
  end # Reporter
end # Queen
