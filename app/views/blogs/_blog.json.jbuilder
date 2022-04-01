json.extract! blog, :id, :title, :article, :created_at, :updated_at
json.url blog_url(blog, format: :json)

json.comments @blog.comments, :id, :comment_for_article, :blog_id, :created_at, :updated_at