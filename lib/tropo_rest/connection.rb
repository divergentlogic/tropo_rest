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

      connection = Faraday::Connection.new(options) do |builder|
        builder.use Faraday::Request::SerializeJson
        builder.use Faraday::Response::Resource, resource
        builder.use Faraday::Response::RaiseHttpErrors
        builder.use Faraday::Response::ParseJson
        builder.adapter(adapter)
      end
      connection.basic_auth(username, password)
      connection
    end
  end
end
