module MetadataCop
  module Cop
    module Xml
      module Lint
        class SchemaValid < Valid
          def investigate(file)
            doc = Nokogiri::XML(File.read(file))

            xsd.validate(doc).map { |m| offense(m) }
          end

          private

          def xsd
            @schema = Nokogiri::XML::Schema(open(xsd_schema_path).read)
          end

          def xsd_schema_path
            options.fetch('EnforcedSchema') { class_schema_path }
          end

          def class_schema_path
            self.class::SCHEMA_PATH if defined? self.class::SCHEMA_PATH
          end
        end
      end
    end
  end
end
