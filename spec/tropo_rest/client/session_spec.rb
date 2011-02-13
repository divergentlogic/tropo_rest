require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#create_session" do

    before do
      @params = {'token' => 'TOKEN'}
      stub_session_post("sessions").
        with(:body => @params).
        to_return(:body => <<-JSON
          {
            "success": true,
            "token": "TOKEN",
            "id": "ID"
          }
          JSON
      )
    end

    it "should make the request" do
      @client.create_session("TOKEN")
      a_session_post("sessions").
        with(:body => @params).should have_been_made
    end

    it "should make the request with parameters" do
      args   = {'phone_number' => '+19995551234', 'name' => 'Billy Gnosis'}
      params = args.merge('token' => 'TOKEN')
      stub_session_post("sessions").
        with(:body => params)
      @client.create_session("TOKEN", args)
      a_session_post("sessions").
        with(:body => params).should have_been_made
    end

    it "should convert all parameters to strings" do
      args   = {'dollars' => 123.45, 'count' => 1}
      params = {'dollars' => '123.45', 'count' => '1', 'token' => 'TOKEN'}
      stub_session_post("sessions").
        with(:body => params)
      @client.create_session("TOKEN", args)
      a_session_post("sessions").
        with(:body => params).should have_been_made
    end

    it "should return the session object" do
      res = @client.create_session("TOKEN")
      res.should == {'success' => true, 'token' => 'TOKEN', 'id' => 'ID'}
    end

  end

end
