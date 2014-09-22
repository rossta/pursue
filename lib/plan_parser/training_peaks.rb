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

    Day = Struct.new(:datename) do
      def date
        Date.strptime(datename, "%m/%d/%Y")
      end

      def day_of_week
        %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday][date.cwday - 1]
      end

      def activities
        @activities ||= []
      end

      def attributes
        { date: date, activities: activities }
      end

      def inspect
        attributes.to_s
      end
    end

    Activity = Struct.new(:tag, :duration, :distance) do
      def posts
        @posts ||= []
      end

      def attributes
        { tag: tag, duration: duration, distance: distance, posts: posts }
      end

      def inspect
        attributes.to_s
      end
    end

    Post = Struct.new(:label, :notes) do
      def attributes
        { label: label, notes: notes }
      end

      def inspect
        attributes.to_s
      end
    end

  end
end
