require 'faraday'
require 'faraday_middleware'
require 'faraday/request/serialize_json'
require 'faraday/response/resource'
require 'faraday/response/raise_http_errors'

module TropoRest
  module Connection
    private

    def connection(url, format, resource)
      options = {
        :headers => {'Accept' => "application/#{format}", 'User-Agent' => user_agent},
        :url => url
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::SerializeJson if format.to_sym == :json
        connection.adapter(adapter)
        connection.basic_auth(username, password)
        connection.use Faraday::Response::ParseJson if format.to_sym == :json
        connection.use Faraday::Response::ParseXml if format.to_sym == :xml
        connection.use Faraday::Response::Resource, resource
        connection.use Faraday::Response::RaiseHttpErrors
      end
    end
  end
end
