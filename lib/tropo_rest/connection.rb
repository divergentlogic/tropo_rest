require 'faraday'

module TropoRest
  module Connection
    private

    def connection
      options = {
        :headers => {'User-Agent' => user_agent},
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |connection|
        connection.adapter(adapter)
        connection.basic_auth(username, password)
      end
    end
  end
end
