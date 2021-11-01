module AccountHelper
  def is_guest?(user)
    user.nil?
  end

  def is_user?(user)
    user.present?
  end

  def missing_avatar?
    !current_user.avatar.attached?
  end
end
