module TropoRest
  module Resource
    class Application < Hashie::Twash

      property :id
      property :href
      property :name
      property :voice_url, :from => :voiceUrl
      property :messaging_url, :from => :messagingUrl
      property :platform
      property :partition

    end
  end
end
