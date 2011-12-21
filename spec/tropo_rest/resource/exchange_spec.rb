require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Resource::Exchange do

  it { should be_kind_of(Hashie::Twash) }

  %w[prefix city state country description sms_enabled].each do |param|
    it { should respond_to(param) }
    it { should respond_to("#{param}=") }
  end

end
