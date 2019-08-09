# The goal of this repo is to act as a template for those wanting to update to the new MeetUp oauth2 exchange




### Instructions: 

* update .exampleenv with your appropriate keys. This is for ease of demo. For deployment or working on your own copy you may want to use `/config/credentials.yml.enc` running `rails credentials:edit` will generate your `master.key` file and your yml file. [references](https://github.com/rails/rails/blob/master/railties/lib/rails/commands/credentials/USAGE)

* deploy to service of your choice

### additional gems installed: 
* [JWT](https://github.com/jwt/ruby-jwt)
* [Rest-Client](https://github.com/rest-client/rest-client)
