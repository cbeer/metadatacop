require 'mods'

module MetadataCop
  module Cop
    module Mods
      module Fields
        class Title < MetadataCop::Cop::BaseCop
          MSG = 'Record must have a title, %{reason}'

          def investigate(file)
            record = ::Mods::Record.new.from_file(file)

            if record.title_info.blank?
              add_offense(reason: 'but unable to find a <titleInfo> element')
            elsif record.full_titles.blank?
              add_offense(reason: 'but unable to find a <titleInfo><title> element')
            elsif record.full_titles.reject(&:blank?).blank?
              add_offense(reason: 'but all titles were blank')
            end
          end
        end
      end
    end
  end
end
