require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#addresses" do

    before do
      stub_get("applications/123456/addresses").to_return(:body => <<-JSON
        [
          {
            "href": "https://api.tropo.com/v1/applications/123456/addresses/sip/99901123456@sip.tropo.com",
            "type": "sip",
            "address": "9990123456@sip.tropo.com",
            "application": "https://api.tropo.com/v1/applications/123456"
          },
          {
            "href": "https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456",
            "type": "skype",
            "number": "+990009369990123456",
            "application": "https://api.tropo.com/v1/applications/123456"
          },
          {
            "href": "https://api.tropo.com/v1/applications/123456/addresses/number/+14075551234",
            "type": "number",
            "prefix": "1407",
            "number": "4075551234",
            "city": "Orlando",
            "state": "FL",
            "application": "https://api.tropo.com/v1/applications/123456"
          },
          {
            "href": "https://api.tropo.com/v1/applications/123456/addresses/aim/tropocloud",
            "type": "aim",
            "username": "tropocloud",
            "application": "https://api.tropo.com/v1/applications/123456"
          }
        ]
        JSON
      )
    end

    it "should make the request with an application ID" do
      @client.addresses(123456)
      a_get("applications/123456/addresses").should have_been_made
    end

    it "should make the request with an address HREF" do
      @client.addresses("https://api.tropo.com/v1/applications/123456/addresses")
      a_get("applications/123456/addresses").should have_been_made
    end

    it "should return a collection of addresses" do
      @client.addresses(123456).should have(4).items
    end

    it "should return the correct addresses" do
      apps    = @client.addresses(123456)
      first   = apps[0]
      second  = apps[1]
      third   = apps[2]
      fourth  = apps[3]

      first.should be_instance_of(TropoRest::Resource::Address)
      first.href.should        == "https://api.tropo.com/v1/applications/123456/addresses/sip/99901123456@sip.tropo.com"
      first.type.should        == "sip"
      first.address.should     == "9990123456@sip.tropo.com"
      first.application.should == "https://api.tropo.com/v1/applications/123456"

      second.should be_instance_of(TropoRest::Resource::Address)
      second.href.should        == "https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456"
      second.type.should        == "skype"
      second.number.should      == "+990009369990123456"
      second.application.should == "https://api.tropo.com/v1/applications/123456"

      third.should be_instance_of(TropoRest::Resource::Address)
      third.href.should        == "https://api.tropo.com/v1/applications/123456/addresses/number/+14075551234"
      third.type.should        == "number"
      third.prefix.should      == "1407"
      third.number.should      == "4075551234"
      third.city.should        == "Orlando"
      third.state.should       == "FL"
      third.application.should == "https://api.tropo.com/v1/applications/123456"

      fourth.should be_instance_of(TropoRest::Resource::Address)
      fourth.href.should        == "https://api.tropo.com/v1/applications/123456/addresses/aim/tropocloud"
      fourth.type.should        == "aim"
      fourth.username.should    == "tropocloud"
      fourth.application.should == "https://api.tropo.com/v1/applications/123456"
    end

  end

  describe "#address" do

    before do
      stub_get("applications/123456/addresses/skype/+99000936209990123456").to_return(:body => <<-JSON
        {
          "href": "https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456",
          "type": "skype",
          "number": "+990009369990123456"
        }
        JSON
      )
    end

    it "should make the request with application ID, address type, and address identifier" do
      @client.address(123456, "skype", "+99000936209990123456")
      a_get("applications/123456/addresses/skype/+99000936209990123456").should have_been_made
    end

    it "should make the request with an address HREF" do
      @client.address("https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456")
      a_get("applications/123456/addresses/skype/+99000936209990123456").should have_been_made
    end

    it "should return an address object" do
      app = @client.address(123456, "skype", "+99000936209990123456")
      app.should be_instance_of(TropoRest::Resource::Address)
      app.href.should    == "https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456"
      app.type.should    == "skype"
      app.number.should  == "+990009369990123456"
    end

  end

  describe "#create_address" do

    before do
      @params = {:type => "number", :prefix => "1407"}
      stub_post("applications/123456/addresses").
        with(:body => @params).
        to_return(:body => %({"href":"https://api.tropo.com/v1/applications/123456/addresses/number/+14075551234"}))
    end

    it "should make the request with an application ID" do
      @client.create_address(123456, @params)
      a_post("applications/123456/addresses").with(:body => @params).should have_been_made
    end

    it "should make the request with an application HREF" do
      @client.create_address("https://api.tropo.com/v1/applications/123456/addresses", @params)
      a_post("applications/123456/addresses").with(:body => @params).should have_been_made
    end

    it "should return the href of the address" do
      res = @client.create_address(123456, @params)
      res.href.should == "https://api.tropo.com/v1/applications/123456/addresses/number/+14075551234"
    end

  end

  describe "#delete_address" do

    before do
      stub_delete("applications/123456/addresses/skype/+99000936209990123456").
        to_return(:body => %({"message": "delete successful"}))
    end

    it "should make the request with application ID, address type, and address identifier" do
      @client.delete_address(123456, "skype", "+99000936209990123456")
      a_delete("applications/123456/addresses/skype/+99000936209990123456").should have_been_made
    end

    it "should make the request with an address HREF" do
      @client.delete_address("https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456")
      a_delete("applications/123456/addresses/skype/+99000936209990123456").should have_been_made
    end

    it "should return the message" do
      res = @client.delete_address(123456, "skype", "+99000936209990123456")
      res.message.should == "delete successful"
    end

  end

end
