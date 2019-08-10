class MeetUpsController < ApplicationController
    #runs your JWT authentication process except for the MeetUp redirect action
    before_action :authenticate, except: [:meetup_handle_token_login]

    # User Schema:
    # create_table "users", force: :cascade do |t|
    #     t.string "meet_up_oauth_token"
    #     t.string "meet_up_refresh_token"
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    #   end

    # your redirect route set up with MeetUp should point to this action. 
    #this is where you will handle generating the JWT token and sending it to the front
    def meetup_handle_token_login
        consumer_key = Rails.application.credentials.meetup[:consumer_key]     
        uri = Rails.application.credentials.meetup[:consumer_redirect_uri] 
        secrete = Rails.application.credentials.meetup[:consumer_secret]
        code =  strong_login_params[:code]
        body = "client_id=#{consumer_key}&client_secret=#{secrete}&grant_type=authorization_code&redirect_uri=#{uri}&code=#{code}"
        
        response = RestClient.post('https://secure.meetup.com/oauth2/access',body, {accept: :json})
        #looks like: {"access_token"=>"xxxxxxx","refresh_token"=>"xxxxxx", "token_type"=>"bearer", "expires_in"=>3600}
        response_json = JSON.parse(response.body)
       
        one_hour_token = response_json["access_token"]
        refresh_token = response_json["refresh_token"]

        #create user from response tokens for authentication requests
        user = User.create(meet_up_oauth_token: one_hour_token, meet_up_refresh_token: refresh_token )

        #this end point for instance gives you all of the users information
        # response2_json = JSON.parse(RestClient.get("https://api.meetup.com/2/member/self/?access_token=#{one_hour_token}"))


        render json: { success: true, token: generate_token(user) }

    end


    def other_routes
        #this uses the jwt token to set the current_user. You can either use the token directly from the JWT or pull up user data you want to associate with the user. 

        # in other routes you will need to create logic to make requests to MeetUp 
        # to refresh token if the user.updated_at vs Time.now is > either than 1 hour or 2 weeks 
        #if you set the token to ageless
        
        request = JSON.parse(RestClient.get("https://api.meetup.com/2/member/self/?access_token=#{current_user.meet_up_oauth_token}"))
        if request["status"] == "active"
            render json: {success: true}
        else 
            render json: {success: false}
        end 
    end

    private
    
    def strong_login_params
        params.require(:login).permit(:code)
    end 
end


# https://secure.meetup.com/oauth2/access
# client_id=YOUR_CONSUMER_KEY
# &client_secret=YOUR_CONSUMER_SECRET
# &grant_type=authorization_code
# &redirect_uri=SAME_REDIRECT_URI_USED_FOR_PREVIOUS_STEP
# &code=CODE_YOU_RECEIVED_FROM_THE_AUTHORIZATION_RESPONSE

# succesful response: 
# {
#   "access_token":"ACCESS_TOKEN_TO_STORE",
#   "token_type":"bearer",
#   "expires_in":3600,
#   "refresh_token":"TOKEN_USED_TO_REFRESH_AUTHORIZATION"
# }