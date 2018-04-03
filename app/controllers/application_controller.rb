class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
  # needed to change when we use devise 2015/12/17
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
  before_action :set_locale


def store_location
 # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get?
    if (request.fullpath != "/users/sign_in" && \
        request.fullpath != "/users/sign_up" && \
        request.fullpath != "/users/password" && \
        !request.fullpath.to_s.include?("/users/") && \
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    end
end

#ログイン後のリダイレクトをログイン前のページにする場合
def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

#ログアウト後のリダイレクトをログアウト前のページにする場合
def after_sign_out_path_for(resource)
  session[:previous_url] || root_path
end

# def default_url_options(options={})
#     {:locale => I18n.locale}
# end


  private
  def extract_locale_from_params
    if params[:locale] and I18n.available_locales.index(params[:locale].to_sym)
      params[:locale]
    end
  end

  def extract_locale_from_accept_language_header
    http_accept_language.compatible_language_from(I18n.available_locales)
  end


  protected
  def set_locale
    I18n.locale = extract_locale_from_accept_language_header ||
        extract_locale_from_params ||
        I18n.default_locale
  end

  # def current_user
  #   current_user ||= User.find_by(id: session[:user_id])
  # end

  # def signed_in?
  #   !!current_user
  # end
  # helper_method :current_user, :signed_in?
  # def current_user=(user)
  #   @current_user = user
  #   session[:user_id] = user.nil? ? nil : user.id
  # end


	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:user_name, :email, :town_list) }
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :town_list) }
	  end
	# realtime_controller({:queue => :redis}) # instruct all requests to enable realtime support via redis
 #    # realtime_controller({:queue => :zmq}) # instruct all requests to enable realtime support via zmq

   #  def realtime_user_id
   #  	return current_user.id
  	# end

  	# def realtime_server_url
   #  	# point this to your node.js-socket.io-redis/zmq realtime server (you can set this later)
   #  	return 'http://localhost:3000' #'http://your-realtime-server.yourdomain.com'
  	# end
end
