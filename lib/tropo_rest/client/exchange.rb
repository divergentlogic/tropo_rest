module TropoRest
  class Client
    module Exchange

      PLURAL_PATH = "exchanges".freeze

      # Returns the exchanges available for the authenticated user
      #
      # @return [Array] The exchanges.
      # @see https://www.tropo.com/docs/rest/prov_view_exchanges.htm
      def exchanges
        get(PLURAL_PATH)
      end

    end
  end
end
