module Faraday
  class Request::UnderscoreToCamel < Faraday::Middleware
    def call(env)
      body = env[:body]
      if body.is_a?(Hash)
        env[:body] = camelize(body)
      elsif body.is_a?(Array)
        env[:body] = body.map{|item| item.is_a?(Hash) ? camelize(item) : item}
      end
      @app.call env
    end

    def camelize(body)
      hash = body.dup
      hash.keys.each do |k|
        value = hash.delete(k)
        key = k.to_s.dup
        if key =~ /_/
          key = key[0].chr.downcase + key.gsub(/(?:^|_)(.)/) { $1.upcase }[1..-1]
        end
        hash[key] = value
      end
      hash
    end
  end
end
