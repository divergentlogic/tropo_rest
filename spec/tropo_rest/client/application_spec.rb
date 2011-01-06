require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#applications" do

    before do
      stub_get("applications").to_return(:body => <<-JSON
        [
          {
            "id": "1",
            "href": "https://api.tropo.com/v1/applications/1",
            "name": "app1",
            "platform": "scripting",
            "voiceUrl": "http://example1.com/voice.rb",
            "messagingUrl": "http://example1.com/messaging.rb",
            "partition": "staging"
          },
          {
            "id": "2",
            "href": "https://api.tropo.com/v1/applications/2",
            "name": "app2",
            "platform": "webapi",
            "voiceUrl": "http://example2.com/voice",
            "messagingUrl": "http://example2.com/messaging",
            "partition": "production"
          }
        ]
        JSON
      )
    end

    it "should make the request" do
      @client.applications
      a_get("applications").should have_been_made
    end

    it "should return a collection of applications" do
      @client.applications.should have(2).items
    end

    it "should return the correct objects" do
      apps  = @client.applications
      first = apps.first
      last  = apps.last

      first["id"].should             == "1"
      first["href"].should           == "https://api.tropo.com/v1/applications/1"
      first["name"].should           == "app1"
      first["platform"].should       == "scripting"
      first["voice_url"].should      == "http://example1.com/voice.rb"
      first["messaging_url"].should  == "http://example1.com/messaging.rb"
      first["partition"].should      == "staging"

      last["id"].should             == "2"
      last["href"].should           == "https://api.tropo.com/v1/applications/2"
      last["name"].should           == "app2"
      last["platform"].should       == "webapi"
      last["voice_url"].should      == "http://example2.com/voice"
      last["messaging_url"].should  == "http://example2.com/messaging"
      last["partition"].should      == "production"
    end

  end

  describe "#application" do

    before do
      stub_get("applications/1").to_return(:body => <<-JSON
        {
          "id": "1",
          "href": "https://api.tropo.com/v1/applications/1",
          "name": "app1",
          "platform": "scripting",
          "voiceUrl": "http://example1.com/voice.rb",
          "messagingUrl": "http://example1.com/messaging.rb",
          "partition": "staging"
        }
        JSON
      )
    end

    it "should make the request with an application ID" do
      @client.application(1)
      a_get("applications/1").should have_been_made
    end

    it "should make the request with an application HREF" do
      @client.application("https://api.tropo.com/v1/applications/1")
      a_get("applications/1").should have_been_made
    end

    it "should return an application object" do
      app = @client.application(1)
      app["id"].should             == "1"
      app["href"].should           == "https://api.tropo.com/v1/applications/1"
      app["name"].should           == "app1"
      app["platform"].should       == "scripting"
      app["voice_url"].should      == "http://example1.com/voice.rb"
      app["messaging_url"].should  == "http://example1.com/messaging.rb"
      app["partition"].should      == "staging"
    end

  end

  describe "#create_application" do

    before do
      @params = {
        :name => "new app",
        :voice_url => "http://website.com",
        :messaging_url => "http://website2.com",
        :platform => "scripting",
        :partition => "staging"
      }
      stub_post("applications").
        with(:body => request_body(@params)).
        to_return(:body => %({"href":"https://api.tropo.com/v1/applications/123456"}))
    end

    it "should make the request" do
      @client.create_application(@params)
      a_post("applications").with(:body => request_body(@params)).should have_been_made
    end

    it "should return the href of the application" do
      res = @client.create_application(@params)
      res["href"].should == "https://api.tropo.com/v1/applications/123456"
    end

  end

  describe "#delete_application" do

    before do
      stub_delete("applications/123456").
        to_return(:body => %({"message": "delete successful"}))
    end

    it "should make the request with an application ID" do
      @client.delete_application(123456)
      a_delete("applications/123456").should have_been_made
    end

    it "should make the request with an application HREF" do
      @client.delete_application("https://api.tropo.com/v1/applications/123456")
      a_delete("applications/123456").should have_been_made
    end

    it "should return a successful message" do
      res = @client.delete_application(123456)
      res["message"].should == "delete successful"
    end

  end

  describe "#update_application" do

    before do
      @params = {
        :name => "newer app",
        :platform => "webapi",
        :partition => "production"
      }
      stub_put("applications/123456").
        with(:body => @params).
        to_return(:body => %({"href":"https://api.tropo.com/v1/applications/123456"}))
    end

    it "should make the request with an application ID" do
      @client.update_application(123456, @params)
      a_put("applications/123456").with(:body => request_body(@params)).should have_been_made
    end

    it "should make the request with an application HREF" do
      @client.update_application("https://api.tropo.com/v1/applications/123456", @params)
      a_put("applications/123456").with(:body => request_body(@params)).should have_been_made
    end

    it "should return the href of the application" do
      res = @client.update_application(123456, @params)
      res["href"].should == "https://api.tropo.com/v1/applications/123456"
    end

  end

end
