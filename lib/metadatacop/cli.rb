module MetadataCop
  class CLI
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def run(*paths)
      runner = Runner.new(runner_options)
      runner.run(paths)

      report_offenses(runner.offenses)

      puts "#{runner.offenses.length} files inspected; #{runner.offenses.values.flatten.length} offenses detected"
      runner.success? ? 0 : 1
    rescue StandardError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      1
    end

    private

    def report_offenses(runner_offenses)
      return if runner_offenses.empty?

      runner_offenses.each do |file, offenses|
        offenses.each do |o|
          puts "#{MetadataCop.colorize(file, :cyan)}: #{o.message} (#{o.cop})"
        end
      end
    end

    def runner_options
      options.merge(cop_options)
    end

    def cop_options
      { cops: enabled_cops }
    end

    def enabled_cops
      ConfigLoader.new(options).cops
    end
  end
end
