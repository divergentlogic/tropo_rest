module TropoRest
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(*args)
      request(:get, *args)
    end

    # Perform an HTTP POST request
    def post(*args)
      request(:post, *args)
    end

    # Perform an HTTP PUT request
    def put(*args)
      request(:put, *args)
    end

    # Perform an HTTP DELETE request
    def delete(*args)
      request(:delete, *args)
    end

  private

    def extract_request_args!(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      path, resource = args
      resource ||= Hashie::Mash
      [path, resource, options]
    end

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
    def request(method, *args)
      path, resource, options = extract_request_args!(*args)
      # Do we need the session endpoint?
      url, format = path =~ /^\/?sessions/ ? [session_endpoint, :xml] : [endpoint, :json]
      response = connection(url, format, resource).send(method) do |request|
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
