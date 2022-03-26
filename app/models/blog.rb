class Blog < ApplicationRecord
	belongs_to :user
	has_many :comments, {dependent: :destroy}
	def comments_count 
		if comments.length == 0
			"No comments"
		elsif comments.length == 1
			"#{comments.length}  comment" 
		else
			"#{comments.length}  comments" 
		end
	end

end
