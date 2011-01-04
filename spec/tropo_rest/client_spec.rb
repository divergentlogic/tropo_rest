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
end
