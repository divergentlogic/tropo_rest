require File.expand_path('../../../spec_helper', __FILE__)

describe TropoRest::Resource::Application do

  it { should be_kind_of(Hashie::Twash) }

  %w[id href name voice_url messaging_url platform partition].each do |param|
    it { should respond_to(param) }
    it { should respond_to("#{param}=") }
  end

end
