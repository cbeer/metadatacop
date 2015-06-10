require 'optparse'

module MetadataCop
  class Options
    def self.parse(args)
      options = {}

      parser(options).parse!(args)
      options
    end

    def self.parser(options)
      OptionParser.new do |opts|
        opts.on('-t', '--type [TYPE]', 'Rules to apply') do |t|
          options[:type] = t
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end
    end
  end
end
