module Faraday
  class Response::CamelToUnderscore < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        body = response[:body]
        if body.is_a?(Hash)
          response[:body] = TropoRest::Utils.underscore(body)
        elsif body.is_a?(Array)
          response[:body] = body.map{|item| item.is_a?(Hash) ? TropoRest::Utils.underscore(item) : item}
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end
  end
end
