require 'mods'

module MetadataCop
  module Cop
    module Mods
      module Fields
        class Identifier < MetadataCop::Cop::BaseCop
          MSG = 'Record must have an identifier, %{reason}'

          def investigate(file)
            record = ::Mods::Record.new.from_file(file)

            add_offense(reason: 'but unable to find an <identifier> element') if record.identifier.blank?
          end
        end
      end
    end
  end
end
