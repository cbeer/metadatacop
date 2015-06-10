module MetadataCop
  module Cop
    module Xml
      module Lint
        class Valid < BaseCop
          def investigate(file)
            doc = Nokogiri::XML(File.read(file))

            doc.errors.map { |m| offense(m) }
          end
        end
      end
    end
  end
end
