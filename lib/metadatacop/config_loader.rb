module MetadataCop
  class ConfigLoader
    METADATACOP_HOME = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))
    DEFAULT_PATH = File.join(METADATACOP_HOME, 'config', '%{type}', 'default.yml')

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def configuration
      @configuration ||= YAML.load_file(default_path)
    end

    def cops
      configuration.select(&method(:cop?)).select(&method(:enabled?)).map do |cop, options|
        cop_class(cop).new(options)
      end
    end

    private

    def cop?(cop, _)
      cop_class(cop) < MetadataCop::Cop::BaseCop
    rescue NameError
      false
    end

    def cop_class(cop_name)
      "MetadataCop/Cop/#{cop_name}".classify.constantize
    end

    def enabled?(_, options)
      options['Enabled'] == true
    end

    def default_path
      self.class::DEFAULT_PATH % options
    end
  end
end
