require 'metadatacop/version'

module MetadataCop
  require 'metadatacop/logger'
  require 'metadatacop/cli'
  require 'metadatacop/runner'
  require 'metadatacop/options'
  require 'metadatacop/config_loader'
  require 'metadatacop/offense'

  require 'metadatacop/cop'
  require 'metadatacop/cop/team'

  require 'active_support/inflector'
  require 'nokogiri'
  require 'open-uri'
  require 'rainbow'
  require 'yaml'

  require 'metadatacop/cop/base_cop'
  require 'metadatacop/cop/xml/lint/valid'
  require 'metadatacop/cop/xml/lint/schema_valid'
  require 'metadatacop/cop/mods/fields/title'
  require 'metadatacop/cop/mods/fields/identifier'
  require 'metadatacop/cop/mods/lint/uri'

  def self.rainbow
    @rainbow ||= Rainbow.new
  end

  def self.colorize(string, *args)
    rainbow.wrap(string).color(*args)
  end
end
