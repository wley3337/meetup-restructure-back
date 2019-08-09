class UsersController < ApplicationController
    before_action :authenticate, except: [:meetup_response_route]

    # your redirect route set up with MeetUp should point to this action. 
    #this is where you will handle generating the JWT token and sending it to the front
    def meetup_response_route
        byebug #here to see what the response looks like. 

    end


    def other_routes
        #this uses the jwt token to set the current_user. You can either use the token directly from the JWT or pull up user data you want to associate with the user. 
        byebug
    end 
end
