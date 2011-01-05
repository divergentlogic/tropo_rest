module TropoRest
  # Utilities
  class Utils
    # Convert hash keys from camel case to underscore
    def self.underscore(hash)
      dup = hash.dup
      dup.keys.select { |k| k =~ /[A-Z]/ }.each do |k|
        value = dup.delete(k)
        key = k.dup
        key.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        key.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        key.tr!("-", "_")
        key.downcase!
        dup[key] = value
      end
      dup
    end

    # Convert hash keys from underscore to camel case
    def self.camelize(hash)
      dup = hash.dup
      dup.keys.each do |k|
        value = dup.delete(k)
        key = k.to_s.dup
        if key =~ /_/
          key = key[0].chr.downcase + key.gsub(/(?:^|_)(.)/) { $1.upcase }[1..-1]
        end
        dup[key] = value
      end
      dup
    end
  end
end
