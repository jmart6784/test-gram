module ApplicationHelper
  def user_avatar(user, size=40)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize: "#{size}x#{size}!"))
    else
      image_tag("default_profile.jpg", width: "#{size}", height: "#{size}")
    end
  end

  def simple_number(num)
    if num.between?(1000, 999999)
      num = num + 0.0
      (num / 1000).round(1).to_s + "K"
    elsif num.between?(1000000, 999999999)
      num = num + 0.0
      (num / 1000000).round(1).to_s + "M"
    elsif num >= 1000000000
      num = num + 0.0
      (num / 1000000000).round(1).to_s + "B"
    else
      num
    end
  end
end
