module MetadataCop
  module Cop
    module Xml
      module Lint
        class Valid < BaseCop
          MSG = 'Record was not XML valid: %{message}'

          def investigate(file)
            doc = Nokogiri::XML(File.read(file))

            doc.errors.map { |m| add_offense(message: m) }
          end
        end
      end
    end
  end
end
