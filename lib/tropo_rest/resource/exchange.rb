module TropoRest
  module Resource
    class Exchange < Hashie::Twash

      property :prefix
      property :city
      property :state
      property :country
      property :description

    end
  end
end
