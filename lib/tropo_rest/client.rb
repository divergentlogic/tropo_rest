module TropoRest
  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    include Connection
    include Request

    require 'tropo_rest/client/application'
    require 'tropo_rest/client/exchange'
    require 'tropo_rest/client/address'

    include TropoRest::Client::Application
    include TropoRest::Client::Exchange
    include TropoRest::Client::Address

    def initialize(options={})
      options = TropoRest.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
