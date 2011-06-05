module Faraday
  class Response::RaiseHttpErrors < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 400
        raise TropoRest::BadRequest, error_message(env)
      when 401
        raise TropoRest::NotAuthorized, error_message(env)
      when 403
        raise TropoRest::AccessDenied, error_message(env)
      when 404
        raise TropoRest::NotFound, error_message(env)
      when 405
        raise TropoRest::MethodNotAllowed, error_message(env)
      when 415
        raise TropoRest::UnsupportedMediaType, error_message(env)
      when 500
        raise TropoRest::InternalServerError, error_message(env)
      when 503
        raise TropoRest::ServiceUnavailable, error_message(env)
      end
    end

  private

    def error_message(env)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{env[:status]}#{error_body(env[:body])}"
    end

    def error_body(body)
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
