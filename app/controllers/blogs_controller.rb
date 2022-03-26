class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
    if params[:search].present?
      @blogs =  Blog.where("article LIKE ?", "%#{params[:search]}%")
    end  
    @blogs = @blogs.order('created_at desc').paginate(page: params[:page], per_page: 10)
    @group = @blogs.in_groups_of(2, false)
    
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @comments = Comment.where(blog_id: params[:id])
    if params[:search].present?
      @comments = @comments.where("comment_for_article LIKE ?", "%" + params[:search] + "%")
    end 
    @comments = @comments.order('created_at desc').paginate(page: params[:page], per_page: 3)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    if @blog.user_id != current_user.id
      redirect_to blog_url(@blog)
    end
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    respond_to do |format|
      if Blog.where(user_id: current_user.id).blank?
        UserMailer.with(user: current_user).welcome_email.deliver_now
      end
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    if @blog.user_id != current_user.id
      redirect_to blog_url(@blog)
    else  
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
          format.json { render :show, status: :ok, location: @blog }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    if @blog.user_id != current_user.id
      redirect_to blog_url(@blog)
    else   
      @blog.destroy
      respond_to do |format|
        format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:title, :article)
  end
end
