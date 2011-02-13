require 'faraday'
require 'faraday_middleware'
require 'faraday/request/serialize_json'
require 'faraday/response/resource'
require 'faraday/response/raise_http_errors'

module TropoRest
  module Connection
    private

    def connection(url, resource)
      options = {
        :headers => {'Accept' => "application/json", 'User-Agent' => user_agent},
        :url => url
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::SerializeJson
        connection.adapter(adapter)
        connection.basic_auth(username, password)
        connection.use Faraday::Response::ParseJson
        connection.use Faraday::Response::Resource, resource
        connection.use Faraday::Response::RaiseHttpErrors
      end
    end
  end
end
