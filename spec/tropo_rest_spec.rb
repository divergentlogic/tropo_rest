require File.expand_path('../spec_helper', __FILE__)

describe TropoRest do

  describe ".client" do

    it "should be a TropoRest::Client" do
      TropoRest.client.should be_kind_of(TropoRest::Client)
    end

  end

  it "should delegate methods to the client" do
    client = double("TropoRest::Client")
    client.stub(:client_method)
    TropoRest.stub(:client).and_return(client)

    client.should_receive(:client_method)
    TropoRest.client_method
  end

end
