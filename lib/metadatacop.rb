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
  require 'yaml'

  require 'metadatacop/cop/base_cop'
  require 'metadatacop/cop/xml/lint/valid'
  require 'metadatacop/cop/xml/lint/schema_valid'
end
