require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#create_session" do

    before do
      @params = {'token' => 'TOKEN', 'action' => 'create'}
      stub_session_get("sessions").
        with(:query => @params).
        to_return(:body => <<-XML
        <session>
            <success>true</success>
            <token>TOKEN</token>
        </session>
        XML
      )
    end

    it "should make the request" do
      @client.create_session("TOKEN")
      a_session_get("sessions").
        with(:query => @params).should have_been_made
    end

    it "should make the request with parameters" do
      params  = {'phone_number' => '+19995551234', 'name' => 'Billy Gnosis'}
      query   = params.merge('action' => 'create', 'token' => 'TOKEN')
      stub_session_get("sessions").
        with(:query => query)
      @client.create_session("TOKEN", params)
      a_session_get("sessions").
        with(:query => query).should have_been_made
    end

    it "should return the session object" do
      res = @client.create_session("TOKEN")
      res.session.should == {'success' => 'true', 'token' => 'TOKEN'}
    end

  end

end
