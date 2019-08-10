class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    # helper_method :generate_token
    
    # private
    
    # generates the token for front end
    def generate_token(user)
        # add or update any information you want in your token here
        # using meetup token because that token expires so you can use it to pull the users
        # refresh token
        payload = {meet_up_oauth_token: user.meet_up_oauth_token}
        #takes the payload, some kind of decription key, and a level of encryption 
        JWT.encode(payload, Rails.application.credentials.secret_key_base , 'HS256')
    end 

    # logs in @current_user
    def current_user
        @current_user ||= authenticate
    end 

    # validates token and returns the current user
    def authenticate
        authenticate_or_request_with_http_token do |token|
            begin
                decoded = decode(token)
                @current_user = User.find_by(meet_up_oauth_token: decoded[0]["meet_up_oauth_token"]) 
            # this will give back a 401 unauthorized if the toekn has been altered
            rescue JWT::DecodeError
                render json: {authorized: false }, status: 401  
            end
        end 
    end 

    #helper for decoding token returns an array where the first element is your payload
    def decode(token)
        # takes the token, the original key, true to confirm the token has not been altered, and the encryption algorithm
        JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })
    end 
end
