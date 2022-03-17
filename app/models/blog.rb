class Blog < ApplicationRecord
	belongs_to :user
	has_many :comments, {dependent: :destroy}

	def count_comments
		if comments.length == 0
			"No comments"
		else
			if comments.length == 1
				"#{comments.length}  comment" 
			else
				"#{comments.length}  comments" 
			end
		end
	end

end
