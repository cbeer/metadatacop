module MetadataCop
  class Runner
    attr_reader :options

    def initialize(options = {})
      @options = options
      @ran = false
    end

    def offenses
      @offenses ||= {}
    end

    def run(*paths)
      paths.flatten.each_with_object(offenses) do |file, h|
        file_offenses = process_file(file).flatten

        h[file] ||= []
        h[file] += file_offenses
      end

      @ran = true

      offenses
    end

    def success?
      offenses.values.all?(&:empty?) && ran?
    end

    def ran?
      @ran
    end

    private

    def process_file(file)
      MetadataCop.logger.debug "Scanning #{file}"

      cop_team.inspect_file(file)
    end

    def cop_team
      MetadataCop::Cop::Team.new(options[:cops], options)
    end
  end
end
