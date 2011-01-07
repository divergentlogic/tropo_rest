module TropoRest
  class Client
    module Exchange

      PLURAL_PATH = "exchanges".freeze
      RESOURCE    = TropoRest::Resource::Exchange

      # Returns the exchanges available for the authenticated user
      #
      # @return [Array] The exchanges.
      # @see https://www.tropo.com/docs/rest/prov_view_exchanges.htm
      def exchanges
        get(PLURAL_PATH, RESOURCE)
      end

    end
  end
end
