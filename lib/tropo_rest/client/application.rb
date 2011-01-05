module TropoRest
  class Client
    module Application

      # Returns the authenticated user's applications
      #
      # @return [Array] The applications.
      # @see https://www.tropo.com/docs/rest/prov_view_apps.htm
      def applications
        get("applications")
      end

      # Returns the application specified by an ID
      #
      # @param id [String, Integer] The ID of the application.
      # @return [Hash] The application.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      def application(id)
        verify_application_id(id)
        get("applications/#{id}")
      end

      # Creates a new application
      #
      # @param params [Hash] The attributes of the application to be created.
      # @option params [String] :name The name of the application. Required.
      # @option params [String] :platform Either "scripting" or "webapi". Required.
      # @option params [String] :partition Either "staging" or "production". Defaults to "staging" if not specified.
      # @option params [String] :voice_url The voice endpoint of the application. Optional.
      # @option params [String] :messaging_url The messaging endpoint of the application. Optional.
      # @return [Hash] An object containing the "href" of the new application
      # @raise [TropoRest::BadRequest] Error raised when invalid parameters are supplied.
      # @see https://www.tropo.com/docs/rest/prov_new_app.htm
      def create_application(params={})
        post("applications", params)
      end

      # Permanently destroys the application specified by an ID
      #
      # @param id [String, Integer] The ID of the application to be deleted.
      # @return [Hash] An object with a "message" attribute indicating success.
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      def delete_application(id)
        verify_application_id(id)
        delete("applications/#{id}")
      end

      # Updates an application
      #
      # @param id [String, Integer] The ID of the application to be updated.
      # @param params [Hash] The attributes to be updated. of the application.
      # @option params [String] :name The name of the application. Required.
      # @option params [String] :platform Either "scripting" or "webapi". Required.
      # @option params [String] :partition Either "staging" or "production". Defaults to "staging" if not specified.
      # @option params [String] :voice_url The voice endpoint of the application. Optional.
      # @option params [String] :messaging_url The messaging endpoint of the application. Optional.
      # @return [Hash] An object containing the "href" of the new application
      # @raise [TropoRest::NotFound] Error raised when ID does not identify an active application.
      # @see https://www.tropo.com/docs/rest/prov_update_name.htm
      # @see https://www.tropo.com/docs/rest/prov_add_urls.htm
      def update_application(id, params={})
        verify_application_id(id)
        put("applications/#{id}", params)
      end

  private

    def verify_application_id(id)
      unless id.respond_to?(:to_i) && id.to_i > 0
        raise TropoRest::ArgumentError, "#{id.inspect} is not a valid application ID"
      end
    end

    end
  end
end
