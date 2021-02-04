class UsersController < ApplicationController
  def index
    if params[:search]
      search_txt = params[:search].downcase
      @users = []

      search_words = search_txt.split(" ")
      
      User.all.select do |user|
        next if current_user === user

        search_words.each do |word|
          if user.first_name.downcase[word] || user.last_name.downcase[word] || user.username.downcase[word]
            @users << user
          end
        end
      end

      @users.uniq!

    else
      @users = []
      User.all.each do |user|
        @users << user
      end
    end
  end

  def more_user_index
    @next_start_point = params[:next].to_i

    if params[:type] === "search"
      search_txt = params[:search].downcase
      @users = []

      search_words = search_txt.split(" ")
      
      User.all.select do |user|
        next if current_user === user

        search_words.each do |word|
          if user.first_name.downcase[word] || user.last_name.downcase[word] || user.username.downcase[word]
            @users << user
          end
        end
      end

      @users.uniq!

      temp_ary = []

      13.times do
        next if @users[@next_start_point].nil?
        temp_ary << @users[@next_start_point]
        @next_start_point += 1
      end
      
      @users = temp_ary

    else
      @users = []
      User.all.each do |user|
        @users << user
      end

      temp_ary = []

      13.times do
        next if @users[@next_start_point].nil?
        temp_ary << @users[@next_start_point]
        @next_start_point += 1
      end
      
      @users = temp_ary
    end

    respond_to do |format|
      format.js { render "users/more_user_index" }
    end
  end

  def show
    @user = User.find(params[:id])

    @user_posts = (@user.posts + @user.video_posts).sort_by(&:created_at).reverse!
  end

  def more_user_show_posts
    @next_start_point = params[:next].to_i
    @user = User.find(params[:id])

    @user_posts = (@user.posts + @user.video_posts).sort_by(&:created_at).reverse!

    temp_ary = []

    21.times do
      next if @user_posts[@next_start_point].nil?
      temp_ary << @user_posts[@next_start_point]
      @next_start_point += 1
    end
    
    @user_posts = temp_ary

    respond_to do |format|
      format.js { render "users/more_user_show_posts" }
    end
  end

  private

  def search_params
    params.require(:user).permit(:search)
  end
end
