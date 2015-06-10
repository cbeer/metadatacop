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

      def offense(message)
        MetadataCop::Offense.new(cop: self.class, message: message)
      end
    end
  end
end
