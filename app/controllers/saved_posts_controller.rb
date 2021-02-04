class SavedPostsController < ApplicationController
  def saved_posts
    @saved_posts = current_user.saved_posts.sort_by(&:created_at).reverse!
  end

  def more_saved_posts
    @saved_posts = current_user.saved_posts.sort_by(&:created_at).reverse!

    temp_ary = []
    @next_start_point = params[:next].to_i

    24.times do
      next if @saved_posts[@next_start_point].nil?
      temp_ary << @saved_posts[@next_start_point]
      @next_start_point += 1
    end
    
    @saved_posts = temp_ary

    respond_to do |format|
      format.js { render "saved_posts/more_saved_posts" }
    end
  end

  def ajax_saved_posts
    if params[:type] === "video"
      @saved_post = SavedPost.find_by(user_id: params[:user_id], video_post_id: params[:id])
      post = VideoPost.find(params[:id])

      unless current_user.id === post.user_id
        if @saved_post
          @saved_post.destroy
          @save_txt = "far fa-bookmark"
        else
          SavedPost.create!(user_id: params[:user_id], video_post_id: params[:id])
          @save_txt = "fas fa-bookmark"
        end
      end
    elsif params[:type] === "image"
      @saved_post = SavedPost.find_by(user_id: params[:user_id], post_id: params[:id])
      post = Post.find(params[:id])

      unless current_user.id === post.user_id
        if @saved_post
          @saved_post.destroy
          @save_txt = "far fa-bookmark"
        else
          SavedPost.create!(user_id: params[:user_id], post_id: params[:id])
          @save_txt = "fas fa-bookmark"
        end
      end
    end
  end
end
