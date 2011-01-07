require File.expand_path('../../spec_helper', __FILE__)

describe TropoRest::Client do

  describe "configuration" do

    before do
      TropoRest.reset
    end

    it "uses defaults set on TropoRest" do
      TropoRest.configure do |config|
        config.username         = "username"
        config.password         = "password"
        config.adapter          = :em_synchrony
        config.endpoint         = "http://api.tropo.com/v1/"
        config.session_endpoint = "http://api.tropo.com/1.0/"
        config.user_agent       = "RSpec"
      end
      client = TropoRest::Client.new
      client.username.should          == "username"
      client.password.should          == "password"
      client.adapter.should           == :em_synchrony
      client.endpoint.should          == "http://api.tropo.com/v1/"
      client.session_endpoint.should  == "http://api.tropo.com/1.0/"
      client.user_agent.should        == "RSpec"
    end

    it "can be initialized with options hash" do
      client = TropoRest::Client.new \
        :username =>          "username",
        :password =>          "password",
        :adapter =>           :em_synchrony,
        :endpoint =>          "http://api.tropo.com/v1/",
        :session_endpoint =>  "http://api.tropo.com/1.0/",
        :user_agent =>        "RSpec"
      client.username.should          == "username"
      client.password.should          == "password"
      client.adapter.should           == :em_synchrony
      client.endpoint.should          == "http://api.tropo.com/v1/"
      client.session_endpoint.should  == "http://api.tropo.com/1.0/"
      client.user_agent.should        == "RSpec"
    end

    it "should have sensible defaults" do
      client = TropoRest::Client.new
      client.username.should          be_nil
      client.password.should          be_nil
      client.adapter.should           == Faraday.default_adapter
      client.endpoint.should          == "https://api.tropo.com/v1/"
      client.session_endpoint.should  == "https://api.tropo.com/1.0/"
      client.user_agent.should        == "TropoRest Ruby Gem #{TropoRest::VERSION}"
    end

  end

  describe "request" do

    before do
      @client = TropoRest::Client.new
    end

    it "should respond to GET" do
      @client.should respond_to(:get)
    end

    it "should perform GET" do
      stub_get("somewhere")
      @client.get("somewhere")
      a_get("somewhere").should have_been_made
    end

    it "should respond to POST" do
      @client.should respond_to(:post)
    end

    it "should perform POST" do
      stub_post("somewhere")
      @client.post("somewhere", {:foo => "bar"})
      a_post("somewhere").with(:body => {:foo => "bar"}).should have_been_made
    end

    it "should respond to PUT" do
      @client.should respond_to(:put)
    end

    it "should perform PUT" do
      stub_put("somewhere")
      @client.put("somewhere", {:foo => "bar"})
      a_put("somewhere").with(:body => {:foo => "bar"}).should have_been_made
    end

    it "should respond to DELETE" do
      @client.should respond_to(:delete)
    end

    it "should perform DELETE" do
      stub_delete("somewhere")
      @client.delete("somewhere")
      a_delete("somewhere").should have_been_made
    end

    it "should use authenticated URL" do
      stub_request(:get, "https://username:password@api.tropo.com/v1/somewhere")
      client = TropoRest::Client.new :username => "username", :password => "password"
      client.get("somewhere")
      a_request(:get, "https://username:password@api.tropo.com/v1/somewhere").should have_been_made
    end

    it "should send the correct User-Agent" do
      stub_get("somewhere")
      @client.get("somewhere")
      a_get("somewhere").with(:headers => {"User-Agent" => @client.user_agent}).should have_been_made
    end

    context "sessions" do

      it "should use the session URL if the path passed in starts with 'sessions'" do
        stub_request(:get, "https://api.tropo.com/1.0/sessions")
        @client.get("sessions")
        a_request(:get, "https://api.tropo.com/1.0/sessions").should have_been_made
      end

      it "should send XML Accept header for session requests" do
        params = {'action' => 'create', 'token' => 'TOKEN'}
        stub_session_get("sessions").with(:query => params)
        @client.get("sessions", params)
        a_session_get("sessions").with(:query => params, :headers => {"Accept" => "application/xml"}).should have_been_made
      end

      context "signals" do

        it "should send JSON Accept header" do
          params = {"signal" => "exit"}
          stub_session_post("sessions/abcd/signals").with(:body => params)
          @client.post("sessions/abcd/signals", params)
          a_session_post("sessions/abcd/signals").with(:body => params, :headers => {"Accept" => "application/json"}).should have_been_made
        end

      end

    end

    it "should send JSON Accept header" do
      stub_get("somewhere")
      @client.get("somewhere")
      a_get("somewhere").with(:headers => {"Accept" => "application/json"}).should have_been_made
    end

    it "should send JSON Content-Type header" do
      stub_get("somewhere")
      @client.get("somewhere")
      a_get("somewhere").with(:headers => {"Content-Type" => "application/json"}).should have_been_made
    end

    it "should use JSON encoded requests" do
      params = {'hello' => 'world', 'array' => [1, 2, 3]}
      stub_post("somewhere")
      @client.post("somewhere", params)
      a_post("somewhere").with(:body => params).should have_been_made
    end

    it "should decode JSON responses" do
      params = {'hello' => 'world', 'array' => [1, 2, 3]}
      body   = MultiJson.encode(params)
      stub_get("somewhere").to_return(:body => body)
      res = @client.get("somewhere")
      res.should == params
    end

    context "underscore and camel case" do

      before do
        class TestResource < Hashie::Twash
          property :voice_url, :from => :voiceUrl
          property :messaging_url, :from => :messagingUrl
        end
        @underscore = {'voice_url' => 'http://example.com', 'messaging_url' => 'http://example2.com'}
        @camel_case = {'voiceUrl' => 'http://example.com', 'messagingUrl' => 'http://example2.com'}
      end

      it "should convert request params to camel case" do
        stub_post("somewhere")
        @client.post("somewhere", TestResource.new(@underscore))
        a_post("somewhere").with(:body => @camel_case).should have_been_made
      end

      it "should convert response params to underscore" do
        stub_get("somewhere").to_return(:body => MultiJson.encode(@camel_case))
        res = @client.get("somewhere", TestResource)
        res.should == @underscore
      end

    end

  end

  describe "errors" do

    before do
      @client = TropoRest::Client.new
    end

    it "should raise Bad Request on 400 status code" do
      stub_get("error").to_return(:status => 400)
      lambda { @client.get("error") }.should raise_error(TropoRest::BadRequest)
    end

    it "should raise Not Authorized on 401 status code" do
      stub_get("error").to_return(:status => 401)
      lambda { @client.get("error") }.should raise_error(TropoRest::NotAuthorized)
    end

    it "should raise Access Denied on 403 status code" do
      stub_get("error").to_return(:status => 403)
      lambda { @client.get("error") }.should raise_error(TropoRest::AccessDenied)
    end

    it "should raise Not Found on 404 status code" do
      stub_get("error").to_return(:status => 404)
      lambda { @client.get("error") }.should raise_error(TropoRest::NotFound)
    end

    it "should raise Method Not Allowed on 405 status code" do
      stub_get("error").to_return(:status => 405)
      lambda { @client.get("error") }.should raise_error(TropoRest::MethodNotAllowed)
    end

    it "should raise Unsupported Media Type on 415 status code" do
      stub_get("error").to_return(:status => 415)
      lambda { @client.get("error") }.should raise_error(TropoRest::UnsupportedMediaType)
    end

    it "should raise Internal Server Error on 500 status code" do
      stub_get("error").to_return(:status => 500)
      lambda { @client.get("error") }.should raise_error(TropoRest::InternalServerError)
    end

    it "should raise Service Unavailable on 503 status code" do
      stub_get("error").to_return(:status => 503)
      lambda { @client.get("error") }.should raise_error(TropoRest::ServiceUnavailable)
    end

  end

end
