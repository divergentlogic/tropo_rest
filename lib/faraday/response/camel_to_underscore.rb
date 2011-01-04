module Faraday
  class Response::CamelToUnderscore < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        body = response[:body]
        if body.is_a?(Hash)
          response[:body] = underscore(body)
        elsif body.is_a?(Array)
          response[:body] = body.map{|item| item.is_a?(Hash) ? underscore(item) : item}
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end

    def self.underscore(body)
      hash = body.dup
      hash.keys.select { |k| k =~ /[A-Z]/ }.each do |k|
        value = hash.delete(k)
        key = k.dup
        key.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        key.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        key.tr!("-", "_")
        key.downcase!
        hash[key] = value
      end
      hash
    end
  end
end