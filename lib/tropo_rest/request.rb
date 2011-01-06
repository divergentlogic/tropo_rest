module TropoRest
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options={})
      request(:post, path, options)
    end

    # Perform an HTTP PUT request
    def put(path, options={})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={})
      request(:delete, path, options)
    end

    private

    # if a user passes in an HREF of a Tropo endpoint, return the path
    # otherwise, mash the args into the supplied template
    def get_path(template, *args)
      first = args.first
      if first =~ /^#{endpoint}#{template.gsub('%d', '\d+').gsub('%s', '.*')}$/
        uri = URI.parse(first)
        uri.path
      else
        template % args
      end
    end

    # Perform an HTTP request
    def request(method, path, options)
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end
      response.body
    end
  end
end
