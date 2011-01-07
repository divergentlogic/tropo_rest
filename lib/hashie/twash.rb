require 'hashie/dash'

module Hashie
  # A Twash is a two-way Trash. You can get back to the original keys using #to_hash
  class Twash < Hashie::Dash

    # Defines a property on the Twash. Options are as follows:
    #
    # * <tt>:default</tt> - Specify a default value for this property, to be
    # returned before a value is set on the property in a new Dash.
    # * <tt>:from</tt> - Specify the original key name that will be write only.
    def self.property(property_name, options = {})
      super

      if options[:from]
        translations[options[:from].to_sym] = property_name.to_sym
        class_eval <<-RUBY
          def #{options[:from]}=(val)
            self[:#{property_name}] = val
          end
        RUBY
      end
    end

    # Set a value on the Twash in a Hash-like way. Only works
    # on pre-existing properties.
    def []=(property, value)
      if self.class.translations.keys.include? property.to_sym
        send("#{property}=", value)
      elsif property_exists? property
        super
      end
    end

    def to_hash
      out = super
      self.class.translations.each do |from, to|
        to_s = to.to_s
        if out.keys.include?(to_s)
          out[from.to_s] = out.delete(to_s)
        end
      end
      out
    end

    private

    def self.translations
      @translations ||= {}
    end

    # Raises an NoMethodError if the property doesn't exist
    #
    def property_exists?(property)
      unless self.class.property?(property.to_sym)
        raise NoMethodError, "The property '#{property}' is not defined for this Trash."
      end
      true
    end
  end
end
