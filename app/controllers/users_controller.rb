class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :login
  before_action :set_user, only: [:show, :edit, :update, :destroy, :post_update]
  skip_before_filter :require_no_authentication, :only => [:new, :create]

  def index
    if !user_signed_in?
      @user = User.find_by(id: 2)
    end
    gon.watch.tachie = "initial"
    if user_signed_in?
      redirect_to current_user
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @user_evas = @user.evangelists.order("created_at DESC").paginate(:per_page => 12, :page => params[:page])
    # @user_hist = Evangelist.where(id: @user.full_history).paginate(:per_page => 15, :page => params[:page])
    @user_hist = @user.full_history
    @user_p = @user
    @favs = @user.favs
    @liked_evangelists = @user.liked_evangelists

    @user_subed = User.where('id' => @user.array_b).uniq

    gon.watch.tachie = "initial"
  end

  # GET /users/new
  def new
    @user = User.new

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # if @user.save
    #   Mailer.sendmail_confirm(@user).deliver
    # end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Welcome to MediumEditor Demo!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
  if @user == current_user
    respond_to do |format|
      if @user.update(user_params)
        @user.evangelists.each do |e|
          e.user_name = @user.user_name
          e.save!
        end
        format.html { redirect_to @user, notice: 'User settings are updated' }
        format.json { render :show, status: :ok, location: @user }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  def post_update
  if @user == current_user
    respond_to do |format|
      if @user.update(user_params)
        @user.evangelists.each do |e|
          e.user_name = @user.user_name
          e.save!
        end
        format.js
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

  if @user == current_user
    reset_session
    user = User.find(@user_id)
    user.destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Your accout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  end


  def current_user_home
    if user_signed_in?
      redirect_to current_user
    else
      redirect_to users_path
    end
  end

  private

  def login
    if session[:user_id].blank?
      user = User.create
      session[:user_id] = user.id
    end
    @user_id = session[:user_id]
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def tag_cloud
      @towns = User.tag_counts_on(:towns).order('count DESC')
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:file, :user_name,:a_name, :password, :email, :town_list, :following, :followers, :image_user, :user_cate, :bio)
    end
end
