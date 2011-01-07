require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Resource::Address do

  it { should be_kind_of(Hashie::Twash) }

  %w[href type prefix number address city state channel username password token application_id].each do |param|
    it { should respond_to(param) }
    it { should respond_to("#{param}=") }
  end

end
