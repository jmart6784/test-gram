class LikesController < ApplicationController
  def ajax_likes_update
    if params[:type] === "post"
      @post = Post.find(params[:id])
      @like = Like.where(post_id: @post.id, user_id: current_user.id)

      if @like == []
        @post.likes.create!(user_id: current_user.id, post_id: @post.id)
        @like_txt = "fas fa-heart like-icon-col"
      else
        @like.destroy_all
        @like_txt = "far fa-heart"
      end

      @like_count = @post.likes.count.to_s + " " + "Like".pluralize(@post.likes.count)
    elsif params[:type] === "video post"
      @post = VideoPost.find(params[:id])
      @like = Like.where(video_post_id: @post.id, user_id: current_user.id)

      if @like == []
        @post.likes.create!(user_id: current_user.id, video_post_id: @post.id)
        @like_txt = "fas fa-heart like-icon-col"
      else
        @like.destroy_all
        @like_txt = "far fa-heart"
      end

      @like_count = @post.likes.count.to_s + " " + "Like".pluralize(@post.likes.count)
    elsif params[:type] === "comment"
      @comment = Comment.find(params[:id])
      @like = Like.where(comment_id: @comment.id, user_id: current_user.id)

      if @like == []
        @comment.likes.create!(user_id: current_user.id, comment_id: @comment.id)
        @like_txt = "fas fa-heart like-icon-col"
      else
        @like.destroy_all
        @like_txt = "far fa-heart"
      end

      @like_count = @comment.likes.count.to_s + " " + "Like".pluralize(@comment.likes.count)
    end

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
