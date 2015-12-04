class ProfileController < ApplicationController
    
    def view
        if(params.has_key?(:usuario)) then
            @user = User.find(params[:usuario].to_i)
        else
            @user ||= User.find(session[:user_id]) if session[:user_id]  
        end
    end
<<<<<<< HEAD
    
end
=======
end
>>>>>>> b894b37f12599c68e1face019a72772c4d72a954
