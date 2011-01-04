module Faraday
  class Request::MultiJson < Faraday::Middleware
    begin
      require 'multi_json'
    rescue LoadError, NameError => error
      self.load_error = error
    end

    def call(env)
      env[:request_headers]['Content-Type'] = 'application/json'
      if env[:body] && !env[:body].respond_to?(:to_str)
        env[:body] = ::MultiJson.encode(env[:body])
      end
      @app.call env
    end
  end
end
