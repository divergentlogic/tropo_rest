require 'faraday'
require 'faraday/request/multi_json'
# require 'faraday/request/underscore_to_camel'
require 'faraday/response/multi_json'
require 'faraday/response/resource'
# require 'faraday/response/camel_to_underscore'
require 'faraday/response/raise_http_errors'

module TropoRest
  module Connection
    private

    def connection(resource)
      options = {
        :headers => {'Accept' => "application/json", 'User-Agent' => user_agent},
        :url => endpoint
      }

      Faraday::Connection.new(options) do |connection|
        # connection.use Faraday::Request::UnderscoreToCamel
        connection.use Faraday::Request::MultiJson
        connection.adapter(adapter)
        connection.basic_auth(username, password)
        connection.use Faraday::Response::MultiJson
        connection.use Faraday::Response::Resource, resource
        # connection.use Faraday::Response::CamelToUnderscore
        connection.use Faraday::Response::RaiseHttpErrors
      end
    end
  end
end
