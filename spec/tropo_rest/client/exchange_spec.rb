require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#exchanges" do

    before do
      stub_get("exchanges").to_return(:body => <<-JSON
        [
          {
            "prefix": "1321",
            "city": "Orlando",
            "state": "FL",
            "country": "United States",
            "description": "Phone Number w/ SMS"
          },
          {
            "prefix": "1888",
            "country": "United States",
            "description": "Toll Free Phone Number"
          },
          {
            "prefix": "31",
            "country": "Netherlands",
            "description": "International Phone Number"
          }
        ]
        JSON
      )
    end

    it "should make the request" do
      @client.exchanges
      a_get("exchanges").should have_been_made
    end

    it "should return a collection of exchanges" do
      @client.exchanges.should have(3).items
    end

    it "should return the correct objects" do
      apps    = @client.exchanges
      first   = apps[0]
      second  = apps[1]
      third   = apps[2]

      first["prefix"].should        == "1321"
      first["city"].should          == "Orlando"
      first["state"].should         == "FL"
      first["country"].should       == "United States"
      first["description"].should   == "Phone Number w/ SMS"

      second["prefix"].should       == "1888"
      second["country"].should      == "United States"
      second["description"].should  == "Toll Free Phone Number"

      third["prefix"].should        == "31"
      third["country"].should       == "Netherlands"
      third["description"].should   == "International Phone Number"
    end

  end

end
