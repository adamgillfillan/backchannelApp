class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @comments = Comment.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @comment = Comment.new
    flash[:post_id] = Post.find params[:post_id]
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.user = User.find session[:user_id]
    @comment.post = Post.find flash[:post_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment successfully added.' }
        format.json { render action: 'show', status: :created, location: @comment.post }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def get_comments
    @comments = Comment.where(:post_id=>params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end