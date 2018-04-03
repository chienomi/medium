class OmniauthCallbacksController < ApplicationController
	def stripe_connect
    @user = current_user
    if @user.update_attributes({
      provider: request.env["omniauth.auth"].provider,
      uid: request.env["omniauth.auth"].uid,
      access_code: request.env["omniauth.auth"].credentials.token,
      publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })
      # anything else you need to do in response..
        @user.stripe_1 = 1
        @user.save
      	flash[:notice]="Successfully Connected to Stripe!"
		sign_in_and_redirect @user, :event => :authentication
    
    else
    	flash[:error]="Error: Stripe."
      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
    callback_from :facebook
  end

  def google
    callback_from :google
  end

  def twitter
    callback_from :twitter
  end

  private
    def callback_from(provider)
      provider = provider.to_s

      @user = User.find_for_oauth(request.env['omniauth.auth'], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth'].except("extra")
        redirect_to new_user_registration_url
      end
    end
end