module TropoRest
  module Resource
    class Address < Hashie::Twash

      property :href
      property :type
      property :prefix
      property :number
      property :address
      property :city
      property :state
      property :channel
      property :username
      property :password
      property :token
      property :application_id

    end
  end
end
