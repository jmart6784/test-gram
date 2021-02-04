class VideoPostsController < ApplicationController
  before_action :set_video_post, only: [:edit, :update, :destroy]

  def new
    @video_post = VideoPost.new
  end

  def create
    @video_post = VideoPost.new(video_post_params)
    @video_post.user_id = current_user.id

    if @video_post.save
      redirect_to @video_post
    else 
      flash.now[:danger] = "Can't create this Post, there are errors."
      render "new"
    end
  end

  def show
    @post = VideoPost.find(params[:id])
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
    @video_post = VideoPost.find(params[:id])
  end

  def update
    @video_post = VideoPost.find(params[:id])
    @video_post.user_id = current_user.id
    @video_post.update(video_post_params)
    redirect_to video_post_path(@video_post)
  end

  def destroy
    @video_post = VideoPost.find(params[:id])
    @video_post.destroy
    redirect_to current_user
  end

  private

  def video_post_params
    params.require(:video_post).permit(:caption, :clip)
  end

  def set_video_post
    if VideoPost.find(params[:id]).user != current_user
      redirect_to video_posts_path
    end
  end
end
