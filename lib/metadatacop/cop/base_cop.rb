module MetadataCop
  module Cop
    class BaseCop
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def message(params = {})
        self.class::MSG % params
      end

      def lint?
        self.class.to_s =~ /Lint/
      end

      def add_offense(options = {})
        MetadataCop::Offense.new(cop: self.class, severity: severity, message: message(options))
      end

      private

      def default_severity
        'ERROR'
      end
    end
  end
end
