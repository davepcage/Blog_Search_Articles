class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_blog, only: %i[ index show new edit create update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]


  # GET /comments or /comments.json
  def index
    @comments = Comment.where(blog_id: params[:blog_id])

    if params[:search].present?
      @comments = @comments.where("comment_for_article LIKE ?", "%" +params[:search]+ "%")
    end 

    @comments = @comments.order('created_at desc').paginate(page: params[:page], per_page: 5)
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    redirect_on_incorrect_user && return if other_user?
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params.merge(blog: @blog, user: current_user))   

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_url(@blog), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    redirect_on_incorrect_user && return if other_user?
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to blog_url(@blog), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    redirect_on_incorrect_user && return if other_user?

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to blog_url(@blog), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment_for_article, :blog_id)
    end

    def other_user?
      @comment.user_id != current_user.id
    end

    def redirect_on_incorrect_user
      redirect_to blog_url(@blog) 
    end
end
