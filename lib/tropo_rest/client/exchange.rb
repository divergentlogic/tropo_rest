module TropoRest
  class Client
    module Exchange

      # Returns the exchanges available for the authenticated user
      #
      # @return [Array] The exchanges.
      # @see https://www.tropo.com/docs/rest/prov_view_exchanges.htm
      def exchanges
        get("exchanges")
      end

    end
  end
end
