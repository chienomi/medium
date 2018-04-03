class OnlineformsController < ApplicationController
  before_action :set_onlineform, only: [:show, :edit, :update, :destroy]

  # GET /onlineforms
  def index
    @onlineforms = Onlineform.all
    @user = current_user
    if @user == nil
      @user = User.find_by(id: 4)
    end
  end

  # GET /onlineforms/1
  def show
    @user = current_user
    if @user == nil
      @user = User.find_by(id: 4)
    end
  end

  # GET /onlineforms/new
  def new
    @onlineform = Onlineform.new
  end

  # GET /onlineforms/1/edit
  def edit
  end

  # POST /onlineforms
  def create
    @onlineform = Onlineform.new(onlineform_params)
    if user_signed_in?
      @onlineform.user_id = current_user.id
    end

    if @onlineform.save
      redirect_to @onlineform, notice: 'Onlineform was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /onlineforms/1
  def update
    if @onlineform.update(onlineform_params)
      redirect_to @onlineform, notice: 'Onlineform was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /onlineforms/1
  def destroy
    @onlineform.destroy
    redirect_to onlineforms_url, notice: 'Onlineform was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_onlineform
      @onlineform = Onlineform.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def onlineform_params
      params.require(:onlineform).permit(:title, :whatkind, :body, :disclose, :user_id)
    end
end
