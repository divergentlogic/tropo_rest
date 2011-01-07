module TropoRest
  class Client
    module Address

      SINGULAR_PATH = "applications/%d/addresses/%s/%s".freeze
      PLURAL_PATH   = "applications/%d/addresses".freeze
      RESOURCE      = TropoRest::Resource::Address

      # Returns the addresses for the specified application
      #
      # @param application_id [String, Integer] The ID of the application.
      # @return [Array] The addresses.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      # @see https://www.tropo.com/docs/rest/prov_view_app_addresses.htm
      def addresses(application_id)
        path = get_path(PLURAL_PATH, application_id)
        get(path, RESOURCE)
      end

      # Returns the specified address
      #
      # @overload address(application_id, type, identifier)
      #   @param application_id [String, Integer] The ID of the application.
      #   @param type [String] The type of address (aim, gtalk, jabber, msn, skype, number, token, yahoo)
      #   @param identifier [String] The address, number, or username
      # @overload address(href)
      #   @param href [String] The HREF of the address
      # @return [TropoRest::Resource::Address] The address.
      # @raise [TropoRest::NotFound] Error raised when address not found.
      def address(*args)
        path = get_path(SINGULAR_PATH, *args)
        get(path, RESOURCE)
      end

      # Creates a new address for the specified application
      #
      # @param application_id_or_href [String, Integer] The ID or HREF of the application.
      # @param params [Hash] The attributes of the address to be created.
      # @option params [String] :type The type of address to create (aim, gtalk, jabber, msn, number, token, yahoo). Required.
      # @option params [String] :prefix The country and area code for a number
      # @option params [String] :number A complete phone number already assigned to an existing application
      # @option params [String] :channel Either "voice" or "messaging", used when creating a token
      # @option params [String] :username An IM username. Required when adding an IM account
      # @option params [String] :password An IM password. Required when adding an IM account
      # @return [Hashie::Mash] An object containing the "href" of the new application
      # @raise [TropoRest::BadRequest] Error raised when invalid parameters are supplied.
      # @see https://www.tropo.com/docs/rest/prov_add_number.htm
      # @see https://www.tropo.com/docs/rest/prov_add_toll_free.htm
      # @see https://www.tropo.com/docs/rest/prov_add_international.htm
      # @see https://www.tropo.com/docs/rest/prov_add_specific_num.htm
      # @see https://www.tropo.com/docs/rest/prov_add_im.htm
      # @see https://www.tropo.com/docs/rest/prov_add_token.htm
      def create_address(application_id_or_href, params={})
        path = get_path(PLURAL_PATH, application_id_or_href)
        post(path, RESOURCE.new(params))
      end

      # Removes an address from an application
      #
      # @overload delete_address(application_id, type, identifier)
      #   @param application_id [String, Integer] The ID of the application.
      #   @param type [String] The type of address (aim, gtalk, jabber, msn, skype, number, token, yahoo)
      #   @param identifier [String] The address, number, or username
      # @overload delete_address(href)
      #   @param href [String] The HREF of the address to be deleted.
      # @return [Hashie::Mash] An object with a "message" attribute indicating success.
      # @raise [TropoRest::NotFound] Error raised when address not found.
      # @see https://www.tropo.com/docs/rest/prov_delete_address.htm
      def delete_address(*args)
        path = get_path(SINGULAR_PATH, *args)
        delete(path)
      end

    end
  end
end
