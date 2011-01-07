module TropoRest
  class Client
    module Signal

      PLURAL_PATH = "sessions/%s/signals".freeze

      # Sends a signal for the given session ID
      #
      # @param session_id [String] The 16-byte GUID session ID.
      # @param signal [String] The signal to send to the session.
      # @return [Hashie::Mash] The signal object. Will have a field "status" with one of these values: "QUEUED", "NOTFOUND", "FAILED"
      # @see https://www.tropo.com/docs/rest/interrupting_code_one_signal.htm
      # @see https://www.tropo.com/docs/rest/interrupting_code_multiple.htm
      # @see https://www.tropo.com/docs/rest/unnamed_signals.htm
      # @see https://www.tropo.com/docs/rest/redirecting_app_based_on_signal.htm
      # @see https://www.tropo.com/docs/rest/event_queuing.htm
      # @see https://www.tropo.com/docs/rest/starting_session.htm
      # @see https://www.tropo.com/docs/rest/parameters.htm
      def create_signal(session_id, signal)
        path = get_path(PLURAL_PATH, session_id)
        post(path, {"signal" => signal})
      end

    end
  end
end
