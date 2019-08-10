Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #handles meetup's redirect back to the server
  post '/meetup/login', to: "meet_ups#meetup_handle_token_login"

  #template for all other routes- requires a bearer token from the front 
  get '/other/routes', to: "meet_ups#other_routes"
end
