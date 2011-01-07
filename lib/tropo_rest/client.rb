module TropoRest
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    include Connection
    include Request

    require 'tropo_rest/client/application'
    require 'tropo_rest/client/exchange'
    require 'tropo_rest/client/address'
    require 'tropo_rest/client/session'

    include TropoRest::Client::Application
    include TropoRest::Client::Exchange
    include TropoRest::Client::Address
    include TropoRest::Client::Session

    def initialize(options={})
      options = TropoRest.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
