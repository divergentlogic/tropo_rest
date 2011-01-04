module TropoRest
  # Custom error class for rescuing from all TropoRest errors
  #
  # @see https://www.tropo.com/docs/rest/response_codes.htm
  class Error < StandardError; end

  # Raised when Tropo returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Tropo returns the HTTP status code 401
  class NotAuthorized < Error; end

  # Raised when Tropo returns the HTTP status code 403
  class AccessDenied < Error; end

  # Raised when Tropo returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Tropo returns the HTTP status code 405
  class MethodNotAllowed < Error; end

  # Raised when Tropo returns the HTTP status code 415
  class UnsupportedMediaType < Error; end

  # Raised when Tropo returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Tropo returns the HTTP status code 503
  class ServiceUnavailable < Error; end
end
