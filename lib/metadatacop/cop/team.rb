module MetadataCop
  module Cop
    class Team
      attr_reader :cops, :options

      def initialize(cops, options = {})
        @cops = cops
        @options = options
      end

      def inspect_file(file)
        linters, others = @cops.partition(&:lint?)

        result = run_cops(linters, file)

        # if the linters failed, no reason to run the others
        result += run_cops(others, file) if result.empty?

        result
      end

      def run_cops(cops, file)
        MetadataCop.logger.debug "Running cops: #{cops.inspect} on #{file}"
        cops.inject([]) do |offenses, cop|
          offenses + Array.wrap(cop.investigate(file))
        end
      end
    end
  end
end
