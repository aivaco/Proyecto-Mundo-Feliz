class ProfileController < ApplicationController
    
    def view
        if(params.has_key?(:usuario)) then
            @user = User.find(params[:usuario].to_i)
        else
            @user ||= User.find(session[:user_id]) if session[:user_id]  
        end
    end
    
end
