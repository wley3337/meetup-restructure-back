# The goal of this repo is to act as a template for those wanting to update to the new MeetUp oauth2 exchange


### General Information: 
* MeetUpsController has internal instructions on the main exchange with MeetUp oauth2 process
* ApplicationsController has all JWT authorization actions
* Routes Info:
```
  #handles meetup's redirect back to the server
  post '/meetup/login', to: "meet_ups#meetup_handle_token_login"

  #template for all other routes- requires a bearer token from the front
  get '/other/routes', to: "meet_ups#other_routes"
  ```

* Be sure to update credentials.yml with your appropriate keys. You can create/edit this file with the following comand or follow instructions in credentialsYMLExample: 
[references](https://www.viget.com/articles/storing-secret-credentials-in-rails-5-2-and-up)

    ` EDITOR="**EDITOR-OF-CHOICE-HERE** --wait" bin/rails credentials:edit `
* User Schema:
```
create_table "users", force: :cascade do |t|
    t.string "meet_up_oauth_token"
    t.string "meet_up_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```


### additional gems installed: 
* [JWT](https://github.com/jwt/ruby-jwt)
* [Rest-Client](https://github.com/rest-client/rest-client)


### MeetUp End points:

Below is a table of the available Meetup API scopes names an their associated permissions.
[reference](meetup.com/meetup_api/auth/#oauth2-resources)

```

scope 	| permission

ageless	| Replaces the one hour expiry time from oauth2 tokens with a limit of up to two weeks

basic	| Access to basic Meetup group info and creating and editing Events and RSVP's, posting photos in version 2 API's and below

event_management | Allows the authorized application to create and make modifications to events in your Meetup groups on your behalf

group_edit | Allows the authorized application to edit the settings of groups you organize on your behalf

group_content_edit | Allows the authorized application to create, modify and delete group content on your behalf

group_join | Allows the authorized application to join new Meetup groups on your behalf

messaging | Enables Member to Member messaging (this is now deprecated)

profile_edit | Allows the authorized application to edit your profile information on your behalf

reporting | Allows the authorized application to block and unblock other members and submit abuse reports on your behalf

rsvp | Allows the authorized application to RSVP you to events on your behalf
```
