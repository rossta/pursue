module PlanParser
  class TrainingPeaks

    def self.each(filename, &block)
      new(filename).each(&block)
    end

    def initialize(filename)
      @filename = filename
    end

    def open(mode, &block)
      File.open(@filename, mode, &block)
    end

    def each
      open('r').each do |line|
        l = line.strip
        yield categorize_line(l), l
      end
    end

    def categorize_line(line)
      case line
      when "Run", "Other", "Day Off", "Race"
        "tag"
      when %r{^\s+}, "", ":", "view day", "Links"
        "skip"
      when "Workout Description:", "Pre Activity Comments:"
        "label"
      when %r{^Duration}
        "duration"
      when %r{^Distance}
        "distance"
      when %r{^\d+\/\d+}
        "date"
      else
        "notes"
      end

    end

  end
end
