module TropoRest
  module Resource
    class Exchange < Hashie::Twash

      property :prefix
      property :city
      property :state
      property :country
      property :description
      property :sms_enabled, :from => :smsEnabled

    end
  end
end
