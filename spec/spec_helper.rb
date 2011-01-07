Bundler.require
require 'tropo_rest'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include WebMock::API
end

def a_delete(path)
  a_request(:delete, tropo_url_for(path))
end

def a_get(path)
  a_request(:get, tropo_url_for(path))
end

def a_post(path)
  a_request(:post, tropo_url_for(path))
end

def a_put(path)
  a_request(:put, tropo_url_for(path))
end

def stub_delete(path)
  stub_request(:delete, tropo_url_for(path))
end

def stub_get(path)
  stub_request(:get, tropo_url_for(path))
end

def stub_post(path)
  stub_request(:post, tropo_url_for(path))
end

def stub_put(path)
  stub_request(:put, tropo_url_for(path))
end

def a_session_get(path)
  a_request(:get, tropo_session_url_for(path))
end

def a_session_post(path)
  a_request(:post, tropo_session_url_for(path))
end

def stub_session_get(path)
  stub_request(:get, tropo_session_url_for(path))
end

def stub_session_post(path)
  stub_request(:post, tropo_session_url_for(path))
end

def tropo_url_for(path)
  TropoRest.endpoint + path
end

def tropo_session_url_for(path)
  TropoRest.session_endpoint + path
end
