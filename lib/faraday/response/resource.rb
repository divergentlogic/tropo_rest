module Faraday
  class Response::Resource < Response::Middleware
    def on_complete(env)
      if @resource
        response_body = env[:body]
        if response_body.is_a?(Hash)
          env[:body] = @resource.new(response_body)
        elsif response_body.is_a?(Array)
          env[:body] = response_body.map{|item| item.is_a?(Hash) ? @resource.new(item) : item}
        end
      end
    end

    def initialize(app, resource=nil)
      super app
      @resource = resource
      @parser = nil
    end
  end
end
