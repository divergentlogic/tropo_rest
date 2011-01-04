require File.expand_path('../../spec_helper', __FILE__)

describe TropoRest::Client do

  describe "configuration" do

    before do
      TropoRest.reset
    end

    it "uses defaults set on TropoRest" do
      TropoRest.configure do |config|
        config.username   = "username"
        config.password   = "password"
        config.adapter    = :em_synchrony
        config.endpoint   = "http://api.tropo.com/v1/"
        config.user_agent = "RSpec"
      end
      client = TropoRest::Client.new
      client.username.should    == "username"
      client.password.should    == "password"
      client.adapter.should     == :em_synchrony
      client.endpoint.should    == "http://api.tropo.com/v1/"
      client.user_agent.should  == "RSpec"
    end

    it "can be initialized with options hash" do
      client = TropoRest::Client.new \
        :username =>    "username",
        :password =>    "password",
        :adapter =>     :em_synchrony,
        :endpoint =>    "http://api.tropo.com/v1/",
        :user_agent =>  "RSpec"
      client.username.should    == "username"
      client.password.should    == "password"
      client.adapter.should     == :em_synchrony
      client.endpoint.should    == "http://api.tropo.com/v1/"
      client.user_agent.should  == "RSpec"
    end

    it "should have sensible defaults" do
      client = TropoRest::Client.new
      client.username.should    be_nil
      client.password.should    be_nil
      client.adapter.should     == Faraday.default_adapter
      client.endpoint.should    == "https://api.tropo.com/v1/"
      client.user_agent.should  == "TropoRest Ruby Gem #{TropoRest::VERSION}"
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
      stub_get("somewhere").to_return(:status => 200, :headers => {}, :body => "")
      @client.get("somewhere")
      a_get("somewhere").should have_been_made
    end

    it "should respond to POST" do
      @client.should respond_to(:post)
    end

    it "should perform POST" do
      stub_post("somewhere").to_return(:status => 200, :headers => {}, :body => "")
      @client.post("somewhere", {:foo => "bar"})
      a_post("somewhere").with(:body => {:foo => "bar"}).should have_been_made
    end

    it "should respond to PUT" do
      @client.should respond_to(:put)
    end

    it "should perform PUT" do
      stub_put("somewhere").to_return(:status => 200, :headers => {}, :body => "")
      @client.put("somewhere", {:foo => "bar"})
      a_put("somewhere").with(:body => {:foo => "bar"}).should have_been_made
    end

    it "should respond to DELETE" do
      @client.should respond_to(:delete)
    end

    it "should perform DELETE" do
      stub_delete("somewhere").to_return(:status => 200, :headers => {}, :body => "")
      @client.delete("somewhere")
      a_delete("somewhere").should have_been_made
    end

    it "should use authenticated URL" do
      stub_request(:get, "https://username:password@api.tropo.com/v1/somewhere").to_return(:status => 200, :headers => {}, :body => "")
      client = TropoRest::Client.new :username => "username", :password => "password"
      client.get("somewhere")
      a_request(:get, "https://username:password@api.tropo.com/v1/somewhere").should have_been_made
    end

  end

end
