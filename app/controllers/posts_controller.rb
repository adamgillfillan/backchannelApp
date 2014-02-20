class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts.sort!{|a,b| a.activity <=> b.activity}
    @posts.reverse!
    @comments = Comment.all
    @current_user = session[:user_id] ? User.find( session[:user_id]) : nil
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(:post_id=>@post.id)
    puts "Comment ID is: " + @post.id.to_s
    @category_posts = CategoryPost.where(:post_id=>@post.id)
    @categories = []
    @category_posts.each do |c|
      puts "Category name is: " + c.category.name
      @categories << c.category.name;
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.where(:pending => false)
  end

  def upvote
    @post_vote = PostVote.new
    @post_vote.user = User.find session[:user_id]
    @post_vote.post = Post.find params[:id]

    respond_to do |format|
      if @post_vote.save
        format.html { redirect_to post_path, notice: 'Post successfully upvoted.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    index
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = User.find session[:user_id]
    @chosen_categories = params[:categories]
    respond_to do |format|
      if @chosen_categories && @post.save

        #save the categories
        @chosen_categories.each do |c|
          @category_post = CategoryPost.new
          @category_post.post = @post
          @category_post.category = Category.find c
          @category_post.save
        end

        #end save

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        if(!@chosen_categories)
          puts 'error4a'
          format.html { render action: 'new' }
          puts 'error4b'
          format.json { render json: @post.errors << "1 or more categories required.", status: :unprocessable_entity }
          puts 'error4c'
        else
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
