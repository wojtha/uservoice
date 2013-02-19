require 'erb'
require 'yaml'
require 'active_support/hash_with_indifferent_access'
require 'ezcrypto'
require 'action_view'
require 'uservoice/token'
require 'uservoice/view_helpers'

module Uservoice
  class << self
    # Sets the global Uservoice configuration.
    #
    # Call this method to setup default settings in your initializers.
    #
    # @example
    #   Uservoice.config = {
    #     :sso_key    => '1234567890abcdef'
    #     :script_key => '1234567890abcdef'
    #     :subdomain  => 'acme'
    #   }
    #
    def config=(hash)
      @config = hash.symbolize_keys
    end

    # Reads the global Uservoice configuration.
    #
    # Call this method to read or tweak the default settings in your initializers.
    #
    # @example
    #   Uservoice.config.merge! {
    #     :subdomain  => 'acme'
    #   }
    #
    def config
      @config ||= {}
    end

    # Loads the Uservoice configuration from a given YAML file.
    # Evaluates the configuration with ERB before loading.
    def load_configuration(config_file)
      config_file = File.expand_path(config_file)
      config_hash = YAML.load(ERB.new(File.read(config_file)).result).with_indifferent_access
      self.config = config_hash || {}
    end
  end
end

require 'uservoice/railtie' if defined? Rails::Railtie
