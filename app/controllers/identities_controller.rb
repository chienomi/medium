class IdentitiesController < ApplicationController
	def identity_params
      params.require(:identity).permit(:provider, :uid, :description, :email, :first_name, :image,
                  :last_name, :location, :name, :nickname, :phone, :raw_info, :urls)
    end
end
