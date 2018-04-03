class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    auth = request.env['omniauth.auth']
    origin = request.env['omniauth.origin']
    destination = origin.blank? ? root_path : origin
  # Find an identity here
  @identity = Identity.find_with_omniauth(auth)

  if @identity.nil?
    # If no identity was found, create a brand new one here
    @identity = Identity.create_with_omniauth(auth)
  end

  if signed_in?
    if @identity.user == current_user
      # Identity is already associated with this user
      redirect_to @user, notice: "Already logged in and linked!"
    else
      # Identity is not associated with the current_user
      @identity.user = current_user
      @identity.save
      redirect_to @user, notice: "Account was successfully linked!"
    end
  else
    if @identity.user.present?
       # Identity has a user associated with it
      self.current_user = @identity.user
      redirect_to root_url, notice: "Signed in!"
    else
      # No user associated with the identity so we need to create a new one
      user = User.create_with_omniauth(auth['info'])
      @identity.user = user
      @identity.save()
      self.current_user = @identity.user
      redirect_to new_user_url, notice: "Registration successful"
    end
  end
  end

  # DELETE /resource/sign_out
  def destroy
    super
    self.current_user = nil
    # redirect_to root_url, notice: "Signed out successfully"
  end

  def omniauth_failure
    origin = request.env['omniauth.origin']
    destination = origin.blank? ? root_path : origin
    redirect_to destination, alert: "Connection failed"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
