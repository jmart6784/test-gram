class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy, :ajax_comment_create]

  def create
    if params[:video_post_id]
      @post = VideoPost.find(params[:video_post_id])
      @comment = Comment.new
      @comment.body = video_comment_params[:body]
      @comment.video_post_id = params[:video_post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_comments_create' }
        end
      else
        redirect_to @post
      end
    else
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @comment.body = comment_params[:body]
      @comment.post_id = params[:post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_comments_create' }
        end
      else
        redirect_to @post
      end
    end
  end

  def ajax_feed_comment
    if params[:type] === "image"

      @comment = Comment.new
      @comment.body = comment_params[:body]
      @comment.post_id = params[:post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_feed_comment' }
        end
      else
        redirect_to following_feed_path
      end

    elsif params[:type] === "video"

      @comment = Comment.new
      @comment.body = video_comment_params[:body]
      @comment.video_post_id = params[:video_post_id]
      @comment.user_id = current_user.id
      @user = User.find(@comment.user_id)

      if @comment.save
        respond_to do |format|
          format.js { render 'comments/ajax_feed_comment' }
        end
      else
        redirect_to following_feed_path
      end

    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.video_post_id
      @post = VideoPost.find(@comment.video_post_id)
      redirect_to video_post_path(@post)
    else
      @post = Post.find(@comment.post_id)
      redirect_to post_path(@post)
    end

    @comment.destroy
  end

  def more_comments
    if params[:post_type] === "image"
      @post = Post.find(params[:post_id].to_i)
    else
      @post = VideoPost.find(params[:post_id].to_i)
    end

    @user = User.find(@post.user_id)
    @next_start_point = params[:next].to_i

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

    temp_ary2 = []

    15.times do
      next if @comments[@next_start_point].nil?
      temp_ary2 << @comments[@next_start_point]
      @next_start_point += 1
    end
    
    @comments = temp_ary2

    respond_to do |format|
      format.js { render "comments/more_comments" }
    end
  end

  private

  def video_comment_params
    params.require(:comment).permit(:body, :user_id, :video_post_id, :html_text_id, :parent_div_id)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id, :html_text_id, :parent_div_id)
  end

  def set_comment
    if Comment.find(params[:id]).user_id != current_user.id
      redirect_to posts_path
    end
  end
end
