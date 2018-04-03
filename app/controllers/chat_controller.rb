class ChatController  < ApplicationController
	before_action :authenticate_user!, :except => [:show]
  def index
  	if user_signed_in?
      gon.user_id = current_user.id
      gon.user_name = current_user.user_name
    else
    end


  end

  def show
  end
end
