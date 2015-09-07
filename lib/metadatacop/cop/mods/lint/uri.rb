require 'addressable/uri'

module MetadataCop
  module Cop
    module Mods
      module Lint
        class Uri < MetadataCop::Cop::BaseCop
          MSG = 'type="uri" files must contain valid URIs, %{reason}'

          def investigate(file)
            doc = Nokogiri::XML(File.read(file))

            doc.xpath('//*[@type="uri"]/text()').map do |uri|
              validate_uri(uri)
            end.compact
          rescue => e
            add_offense(reason: e)
          end

          def validate_uri(uri)
            if valid_uri?(uri)
              u = Addressable::URI.parse(uri)
              if u.scheme.blank?
                add_offense(reason: "but URI was missing the scheme: #{uri}")
              end
            else
              add_offense(reason: "but unable to parse the URI: #{uri}")
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
