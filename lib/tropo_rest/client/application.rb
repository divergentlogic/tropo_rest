module TropoRest
  class Client
    module Application

      SINGULAR_PATH = "applications/%d".freeze
      PLURAL_PATH   = "applications".freeze
      RESOURCE      = TropoRest::Resource::Application

      # Returns the authenticated user's applications
      #
      # @return [Array] The applications.
      # @see https://www.tropo.com/docs/rest/prov_view_apps.htm
      def applications
        get(PLURAL_PATH, RESOURCE)
      end

      # Returns the application specified by an ID
      #
      # @param id_or_href [String, Integer] The ID or HREF of the application.
      # @return [TropoRest::Resource::Application] The application.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      def application(id_or_href)
        path = get_path(SINGULAR_PATH, id_or_href)
        get(path, RESOURCE)
      end

      # Creates a new application
      #
      # @param params [Hash] The attributes of the application to be created.
      # @option params [String] :name The name of the application. Required.
      # @option params [String] :platform Either "scripting" or "webapi". Required.
      # @option params [String] :partition Either "staging" or "production". Defaults to "staging" if not specified.
      # @option params [String] :voice_url The voice endpoint of the application. Optional.
      # @option params [String] :messaging_url The messaging endpoint of the application. Optional.
      # @return [Hashie::Mash] An object containing the "href" of the new application
      # @raise [TropoRest::BadRequest] Error raised when invalid parameters are supplied.
      # @see https://www.tropo.com/docs/rest/prov_new_app.htm
      def create_application(params={})
        post(PLURAL_PATH, RESOURCE.new(params))
      end

      # Permanently destroys the application specified by an ID
      #
      # @param id_or_href [String, Integer] The ID or HREF of the application to be deleted.
      # @return [Hashie::Mash] An object with a "message" attribute indicating success.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      def delete_application(id_or_href)
        path = get_path(SINGULAR_PATH, id_or_href)
        delete(path)
      end

      # Updates an application
      #
      # @param id_or_href [String, Integer] The ID or HREF of the application to be updated.
      # @param params [Hash] The attributes to be updated. of the application.
      # @option params [String] :name The name of the application. Required.
      # @option params [String] :platform Either "scripting" or "webapi". Required.
      # @option params [String] :partition Either "staging" or "production". Defaults to "staging" if not specified.
      # @option params [String] :voice_url The voice endpoint of the application. Optional.
      # @option params [String] :messaging_url The messaging endpoint of the application. Optional.
      # @return [Hashie::Mash] An object containing the "href" of the new application
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      # @see https://www.tropo.com/docs/rest/prov_update_name.htm
      # @see https://www.tropo.com/docs/rest/prov_add_urls.htm
      def update_application(id_or_href, params={})
        path = get_path(SINGULAR_PATH, id_or_href)
        put(path, RESOURCE.new(params))
      end

    end
  end
end
