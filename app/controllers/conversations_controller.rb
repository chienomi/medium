class ConversationsController < ApplicationController
	before_action :find_evangelist
	before_action :find_conversation, only: [:edit, :update, :destroy]
	 before_filter :authenticate_user!, only: [:destroy, :create, :update]

	def new
		@conversation = Conversation.new
	end

	def create
		if params[:parent_id].to_i > 0
    		parent = Conversation.find_by(id: params[:parent_id])
    		@conversation = parent.children.build(conversation_params)
  		else
    		@conversation = Conversation.new(conversation_params)
  		end

		@conversation = Conversation.new(conversation_params)
		if user_signed_in? && @conversation.body != nil && @conversation.body != ""
			@conversation = @evangelist.conversations.create(conversation_params)
			@conversation.user_id = current_user.id
			@conversation.user_name = current_user.user_name
			@conversation.save!
		elsif @conversation.body != nil && @conversation.body != ""
			@conversation = @evangelist.conversations.create(conversation_params)
			@conversation.user_id = 4
			@conversation.user_name = request.remote_ip
			@conversation.save!
		end
		if @conversation.body != nil && @conversation.body != ""
		@evangelist.come_e = @evangelist.come_e + 1
		@evangelist.updated_at = Time.now
		@evangelist.c_updated_at = Time.now
		@evangelist.save!
		end
		gon.conv = @conversation.body
		gon.test = 1

		#popup part
		if @conversation.a_str != nil
			@a_str = @conversation.a_str.split(",")
			@which_part = @a_str.pop
				#@conversation.a_str << @a_str[]
			@n = @conversation.id

		# change class="c_str c_str_x" to class="c_str c_str_x c_pop_@n" from c_str_x_1 to c_str_x_2
			var = @a_str[0].strip
			@a_str.shift
			while @a_str != []
				var_i = @a_str[0].gsub(/c_str_/,"").to_i
				var_new = "c_str_" + var_i.to_s
				var = var.strip + "|" + var_new.strip
				@a_str.shift
			end

			if @which_part == "1"
				@evangelist.paragraph1 = @evangelist.paragraph1.gsub(/(#{var})/,'\1' + " c_pop_" + @n.to_s + " c_str")
				@evangelist.a_str << @conversation.id
				@evangelist.save!
			elsif @which_part == "2"
				@evangelist.extra = @evangelist.extra.gsub(/(#{var})/,'\1' + " c_pop_" + @n.to_s + " c_str")
				@evangelist.a_str << @conversation.id
				@evangelist.save!
			end
		end

		@conversations = @evangelist.conversations.hash_tree

		render 'create.js'
	end


	def edit
	end

	def update
		if @conversation.update(conversation_params)
			redirect_to evangelist_path(@evangelist)
		else
			render 'edit'
		end
	end

	def destroy
		if user_signed_in?
		if current_user.id == 1
		@conversation.destroy
		redirect_to evangelist_path(@evangelist)
		end
		end
	end


	private
		def conversation_params
			params.require(:conversation).permit(:a_str, :body,:vote,:time,:title,:paragraph,:showside_num,:like,:parent_id)
		end

		def find_evangelist
			@evangelist = Evangelist.friendly.find(params[:evangelist_title])
			@user_p = @evangelist.user
		end

		def find_conversation
			@conversation = Conversation.find(params[:id])
		end
end
