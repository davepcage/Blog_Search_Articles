json.extract! comment, :id, :comment_for_article, :blog_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
