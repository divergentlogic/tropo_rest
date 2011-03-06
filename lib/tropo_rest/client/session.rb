module TropoRest
  class Client
    module Session

      PLURAL_PATH = "sessions".freeze

      # Creates a session for the given token
      #
      # @param token [String] The token of the application.
      # @param params [Hash] The parameters to pass to the session.
      # @return [Hashie::Mash] The session object.
      # @see https://www.tropo.com/docs/rest/starting_session.htm
      def create_session(token, params={})
        params.merge!('token' => token)
        params.merge!(params) { |k,v| v.to_s } # custom parameters must be strings
        response = post(PLURAL_PATH, params)
        response.id = response.id.strip if response.id
        response
      end

    end
  end
end
