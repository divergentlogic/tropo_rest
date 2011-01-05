module TropoRest
  class Client
    module Address

      # Returns the addresses for the specified application
      #
      # @param app_id [String, Integer] The ID of the application.
      # @return [Array] The addresses.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      # @see https://www.tropo.com/docs/rest/prov_view_app_addresses.htm
      def addresses(app_id)
        verify_application_id(app_id)
        get("applications/#{app_id}/addresses")
      end

      # Returns the specified address
      #
      # @param app_id [String, Integer] The ID of the application.
      # @param type [String] The type of address (aim, gtalk, jabber, msn, skype, number, token, yahoo)
      # @param id [String] The address, number, or username
      # @return [Hash] The address.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application or address not found.
      def address(app_id, type, id)
        verify_application_id(app_id)
        get("applications/#{app_id}/addresses/#{type}/#{id}")
      end

      # Creates a new address for the specified application
      #
      # @param app_id [String, Integer] The ID of the application.
      # @param params [Hash] The attributes of the address to be created.
      # @option params [String] :type The type of address to create (aim, gtalk, jabber, msn, number, token, yahoo). Required.
      # @option params [String] :prefix The country and area code for a number
      # @option params [String] :number A complete phone number already assigned to an existing application
      # @option params [String] :channel Either "voice" or "messaging", used when creating a token
      # @option params [String] :username An IM username. Required when adding an IM account
      # @option params [String] :password An IM password. Required when adding an IM account
      # @return [Hash] An object containing the "href" of the new application
      # @raise [TropoRest::BadRequest] Error raised when invalid parameters are supplied.
      # @see https://www.tropo.com/docs/rest/prov_add_number.htm
      # @see https://www.tropo.com/docs/rest/prov_add_toll_free.htm
      # @see https://www.tropo.com/docs/rest/prov_add_international.htm
      # @see https://www.tropo.com/docs/rest/prov_add_specific_num.htm
      # @see https://www.tropo.com/docs/rest/prov_add_im.htm
      # @see https://www.tropo.com/docs/rest/prov_add_token.htm
      def create_address(app_id, params={})
        verify_application_id(app_id)
        post("applications/#{app_id}/addresses", params)
      end

      # Removes an address from an application
      #
      # @param app_id [String, Integer] The ID of the application to be deleted.
      # @param type [String] The type of address (aim, gtalk, jabber, msn, skype, number, token, yahoo)
      # @param id [String] The address, number, or username
      # @return [Hash] An object with a "message" attribute indicating success.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application or address.
      # @see https://www.tropo.com/docs/rest/prov_delete_address.htm
      def delete_address(app_id, type, id)
        verify_application_id(app_id)
        delete("applications/#{app_id}/addresses/#{type}/#{id}")
      end

    end
  end
end
