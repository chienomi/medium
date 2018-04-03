class RegistrationsController < ApplicationController
	skip_before_filter :require_no_authentication
	protected

	# def after_sign_up_path_for(resource)
	# 	'users#current_user_home' # Or :prefix_to_your_route
	# end
end
