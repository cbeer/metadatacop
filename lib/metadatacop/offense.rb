module MetadataCop
  class Offense
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def cop
      options[:cop].to_s.sub('MetadataCop::Cop::', '').underscore
    end

    def message
      options[:message]
    end
  end
end
