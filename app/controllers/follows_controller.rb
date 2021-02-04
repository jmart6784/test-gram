class FollowsController < ApplicationController
  def ajax_follows_update
    @user = User.find(params[:user_id])
    @following = User.find(params[:following_id])
    
    @follow = Follow.find_by(user_id: @user.id, following_id: @following.id)

    unless @user === @following
      if @follow
        @follow.destroy
        @follow_txt = "Follow"
      else
        Follow.create!(user_id: @user.id, following_id: @following.id)
        @follow_txt = "Unfollow"
      end

      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
  end

  def followers_index
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def following_index
    @user = User.find(params[:id])
    @following = @user.following
  end
end
