module Faraday
  class Request::UnderscoreToCamel < Faraday::Middleware
    def call(env)
      body = env[:body]
      if body.is_a?(Hash)
        env[:body] = TropoRest::Utils.camelize(body)
      elsif body.is_a?(Array)
        env[:body] = body.map{|item| item.is_a?(Hash) ? TropoRest::Utils.camelize(item) : item}
      end
      @app.call env
    end
  end
end
