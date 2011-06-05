require 'hashie/mash'
require 'hashie/twash'

require 'tropo_rest/resource/address'
require 'tropo_rest/resource/application'
require 'tropo_rest/resource/exchange'

require 'tropo_rest/version'
require 'tropo_rest/error'
require 'tropo_rest/configuration'
require 'tropo_rest/request'
require 'tropo_rest/connection'
require 'tropo_rest/client'
require 'tropo_rest/utils'

module TropoRest
  extend Configuration

  # Alias for TropoRest::Client.new
  #
  # @param options [Hash] Configuration options.
  # @return [TropoRest::Client]
  def self.client(options={})
    TropoRest::Client.new(options)
  end

  # Delegate to TropoRest::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end
end
