require 'faraday'

module TropoRest
  # Defines constants and methods related to configuration
  module Configuration
    VALID_OPTIONS_KEYS = [:username, :password, :adapter, :endpoint, :user_agent].freeze

    # By default, don't set a username
    DEFAULT_USERNAME = nil.freeze

    # By default, don't set a password
    DEFAULT_PASSWORD = nil.freeze

    # The faraday adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = Faraday.default_adapter.freeze

    # The endpoint that will be used to connect if none is set
    #
    # @note You shouldn't set this unless you don't want to use SSL.
    DEFAULT_ENDPOINT = 'https://api.tropo.com/v1/'.freeze

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "TropoRest Ruby Gem #{TropoRest::VERSION}".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.username   = DEFAULT_USERNAME
      self.password   = DEFAULT_PASSWORD
      self.adapter    = DEFAULT_ADAPTER
      self.endpoint   = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self
    end
  end
end
