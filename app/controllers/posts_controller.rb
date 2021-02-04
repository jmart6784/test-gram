class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    posts = Post.all + VideoPost.all
    temp_ary = []
    @sorted_by_likes = []

    posts.each do |post|
      temp_ary << { likes: post.likes.count, post_obj: post }
    end

    temp_ary = (temp_ary.sort_by { |x| x[:likes] }).reverse!
    
    temp_ary.each do |obj|
      @sorted_by_likes << obj[:post_obj]
    end
  end

  def more_index_posts
    @next_start_point = params[:next].to_i

    posts = Post.all + VideoPost.all
    temp_ary = []
    @sorted_by_likes = []

    posts.each do |post|
      temp_ary << { likes: post.likes.count, post_obj: post }
    end

    temp_ary = (temp_ary.sort_by { |x| x[:likes] }).reverse!
    
    temp_ary.each do |obj|
      @sorted_by_likes << obj[:post_obj]
    end

    temp_ary2 = []

    21.times do
      next if @sorted_by_likes[@next_start_point].nil?
      temp_ary2 << @sorted_by_likes[@next_start_point]
      @next_start_point += 1
    end
    
    @sorted_by_likes = temp_ary2

    respond_to do |format|
      format.js { render "posts/more_index_posts" }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else 
      flash.now[:danger] = "Can't create this Post, there are errors."
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new

    all_comments = @post.comments 

    temp_ary = []
    @comments = []

    all_comments.each do |comment|
      temp_ary << { likes: comment.likes.count, com_obj: comment }
    end

    temp_ary = (temp_ary.sort_by { |x| x[:likes] }).reverse!
    
    temp_ary.each do |obj|
      @comments << obj[:com_obj]
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to current_user
  end

  def following_feed
    @comment = Comment.new
    @following = current_user.following
    @following_posts = []

    @following.each do |user|
      user.posts.each do |post|
        @following_posts << post
      end

      user.video_posts.each do |post|
        @following_posts << post
      end
    end

    @sorted_feed = @following_posts.sort_by(&:created_at).reverse!
  end

  def more_following
    @next_start_point = params[:next].to_i

    @following = current_user.following
    @following_posts = []

    @following.each do |user|
      user.posts.each do |post|
        @following_posts << post
      end

      user.video_posts.each do |post|
        @following_posts << post
      end
    end

    @sorted_feed = @following_posts.sort_by(&:created_at).reverse!

    temp_ary = []

    10.times do
      next if @sorted_feed[@next_start_point].nil?
      temp_ary << @sorted_feed[@next_start_point]
      @next_start_point += 1
    end
    
    @sorted_feed = temp_ary

    respond_to do |format|
      format.js { render "posts/more_following" }
    end
  end

  def activity
    all_likes = []
    all_comments = []

    current_user.posts.each do |post|
      post.likes.each do |like|
        next if current_user.id === like.user_id
        all_likes << like
      end
    end

    current_user.video_posts.each do |post|
      post.likes.each do |like|
        next if current_user.id === like.user_id
        all_likes << like
      end
    end

    current_user.posts.each do |post|
      post.comments.each do |comment|
        next if current_user.id === comment.user_id
        all_comments << comment
      end
    end

    current_user.video_posts.each do |post|
      post.comments.each do |comment|
        next if current_user.id === comment.user_id
        all_comments << comment
      end
    end

    follows = Follow.where(following_id: current_user.id)

    @activity = (all_likes + all_comments + follows).sort_by(&:created_at).reverse!
  end

  def more_activity
    all_likes = []
    all_comments = []

    current_user.posts.each do |post|
      post.likes.each do |like|
        next if current_user.id === like.user_id
        all_likes << like
      end
    end

    current_user.video_posts.each do |post|
      post.likes.each do |like|
        next if current_user.id === like.user_id
        all_likes << like
      end
    end

    current_user.posts.each do |post|
      post.comments.each do |comment|
        next if current_user.id === comment.user_id
        all_comments << comment
      end
    end

    current_user.video_posts.each do |post|
      post.comments.each do |comment|
        next if current_user.id === comment.user_id
        all_comments << comment
      end
    end

    follows = Follow.where(following_id: current_user.id)

    @activity = (all_likes + all_comments + follows).sort_by(&:created_at).reverse!

    @next_start_point = params[:next].to_i

    temp_ary = []

    13.times do
      next if @activity[@next_start_point].nil?
      temp_ary << @activity[@next_start_point]
      @next_start_point += 1
    end
    
    @activity = temp_ary

    respond_to do |format|
      format.js { render "posts/more_activity" }
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    if Post.find(params[:id]).user != current_user
      redirect_to posts_path
    end
  end
end
