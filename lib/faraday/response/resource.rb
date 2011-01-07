module Faraday
  class Response::Resource < Response::Middleware
    class << self
      attr_accessor :resource
    end

    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        if resource
          response_body = response[:body]
          if response_body.is_a?(Hash)
            response[:body] = resource.new(response_body)
          elsif response_body.is_a?(Array)
            response[:body] = response_body.map{|item| item.is_a?(Hash) ? resource.new(item) : item}
          end
        end
      end
    end

    def initialize(app, resource=nil)
      super app
      self.class.resource = resource
      @parser = nil
    end
  end
end
