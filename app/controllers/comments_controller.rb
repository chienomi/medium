class CommentsController < ApplicationController
	before_action :find_demo
	before_action :find_comment, only: [:edit, :update, :destroy]

	def new
		@comment = Comment.new
	end

	def create
		@demo = Demo.find(params[:demo_id])
		@comment = @demo.comments.create(comment_params)
		if user_signed_in?
			@comment.user_id = current_user.id
			@comment.user_name = current_user.user_name
			@comment.save!
		else
			flash[:notice] = "Log in first"
		end

		respond_to do |format|
			format.html { redirect_to @demo }
			format.js # render comments/create.js.erb
		end
	end


	def edit
	end

	def update

		if @comment.update(comment_params)
			redirect_to demo_path(@demo)
		else
			render 'edit'
		end

	end

	def destroy
		@comment.destroy
		redirect_to demo_path(@demo)
	end


	private
		def comment_params
			params.require(:comment).permit(:body, :vote)
		end

		def find_demo
			@demo = Demo.find(params[:demo_id])
		end

		def find_comment
			@comment = Comment.find(params[:id])
		end
end