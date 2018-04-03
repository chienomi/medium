module UsersHelper
	def eva_from_id(id)
		Evangelist.find_by(id: id)
	end
end
