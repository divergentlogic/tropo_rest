require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Client do

  before do
    @client = TropoRest::Client.new
  end

  describe "#create_signal" do

    before do
      @params = {'signal' => 'exit'}
      stub_session_post("sessions/644a27c6da7e505ab432325056671535/signals").
        with(:body => @params).
        to_return(:body => <<-JSON
          {"status": "QUEUED"}
        JSON
      )
    end

    it "should make the request" do
      @client.create_signal("644a27c6da7e505ab432325056671535", "exit")
      a_session_post("sessions/644a27c6da7e505ab432325056671535/signals").
        with(:body => @params).should have_been_made
    end

    it "should return the signal object" do
      res = @client.create_signal("644a27c6da7e505ab432325056671535", "exit")
      res.status.should == "QUEUED"
    end

  end

end
