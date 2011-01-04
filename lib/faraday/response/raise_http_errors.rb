module Faraday
  class Response::RaiseHttpErrors < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 400
          raise TropoRest::BadRequest, error_message(response)
        when 401
          raise TropoRest::NotAuthorized, error_message(response)
        when 403
          raise TropoRest::AccessDenied, error_message(response)
        when 404
          raise TropoRest::NotFound, error_message(response)
        when 405
          raise TropoRest::MethodNotAllowed, error_message(response)
        when 415
          raise TropoRest::UnsupportedMediaType, error_message(response)
        when 500
          raise TropoRest::InternalServerError, error_message(response)
        when 503
          raise TropoRest::ServiceUnavailable, error_message(response)
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end

    private

    def self.error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def self.error_body(body)
      if body.nil?
        nil
      elsif body['error']
        ": #{body['error']}"
      elsif body['errors']
        first = body['errors'].to_a.first
        if first.kind_of? Hash
          ": #{first['message'].chomp}"
        else
          ": #{first.chomp}"
        end
      end
    end
  end
end
