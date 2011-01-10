TropoRest
=========

A simple Ruby wrapper for the Tropo REST API

Installation
------------

    $ gem install tropo_rest

You will also need to install your favorite JSON and XML libraries.
Acceptable choices are yajl-ruby, json, active_support, or json_pure for JSON,
and nokogiri, libxml, or rexml for XML.


Usage Examples
--------------

    require 'tropo_rest'

    TropoRest.configure do |config|
      config.username = 'tropousername'
      config.password = 'tropopassword'
    end

    # Gets all of your applications
    puts TropoRest.applications

    # Gets a specific application by ID
    puts TropoRest.application(123456)

    # You can also pass in the HREF of the application instead of the ID
    puts TropoRest.application('https://api.tropo.com/v1/applications/123456')

    # Create an application
    puts TropoRest.create_application(
      :name => "new app",
      :voice_url => "http://website.com",
      :messaging_url => "http://website2.com",
      :platform => "scripting",
      :partition => "staging"
    ) # returns an object with the "href" of the new application

    # Update an application
    puts TropoRest.update_application(123456,
      :name => "newer app",
      :platform => "webapi",
      :partition => "production"
    ) # returns an object with the "href" of the new application

    # Delete an application
    puts TropoRest.delete_application(123456)

    # Gets all addresses for an application
    puts TropoRest.addresses(123456)

    # Gets a specific address
    puts TropoRest.address(12345, "skype", "+99000936209990123456")

    # You can also pass in the HREF of the address
    puts TropoRest.address("https://api.tropo.com/v1/applications/123456/addresses/skype/+99000936209990123456")

    # Create an address
    puts TropoRest.create_address(123456,
      :type => "number",
      :prefix => "1407"
    ) # returns an object with the "href" of the new address

    # Delete an address
    puts TropoRest.delete_address(123456, "skype", "+99000936209990123456")

    # Gets all of the exchanges
    puts TropoRest.exchanges

    # Creates a session for the given token
    puts TropoRest.create_session("TOKEN")

    # Sends a signal to a current session.
    # First parameter is the session ID, second is the signal to send.
    puts TropoRest.create_signal("9a5c43f30b414d51901c4cfde00f43e8", "exit")


Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


Credits
-------

Thanks to [Tropo](https://www.tropo.com/) for creating such an awesome service.

Thanks to the creators of the [twitter](https://github.com/jnunemaker/twitter/) gem, whose lovely code I shamelessly ripped off :)


Copyright
---------

Copyright (c) 2011 Christopher Durtschi. See LICENSE for details.
