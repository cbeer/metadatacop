require 'mods'

module MetadataCop
  module Cop
    module Mods
      module Fields
        class Identifier < MetadataCop::Cop::BaseCop
          MSG = 'Record must have an identifier, %{reason}'

          def investigate(file)
            record = ::Mods::Record.new.from_file(file)
            errors = []

            if record.identifier.blank?
              errors << add_offense(reason: 'but unable to find an <identifier> element')
            end

            errors += validate_uris(record.identifier.select { |x| x.type_at == 'uri' })

            errors
          end

          def validate_uris(identifiers)
            identifiers.map do |x|
              uri = x.text
              if valid_uri?(uri)
                u = Addressable::URI.parse(uri)
                add_offense(reason: "but URI was missing the scheme: #{uri}")  unless u.scheme
              else
                add_offense(reason: "but unable to parse the URI: #{uri}")
              end
            end
          end

          def valid_uri?(uri)
            Addressable::URI.parse(uri)
          rescue Addressable::InvalidURIError
            false
          end
        end
      end
    end
  end
end
