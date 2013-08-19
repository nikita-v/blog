class CommentAuthorizer < ApplicationAuthorizer
  def creatable_by?(user)
    true
  end

  def deletable_by?(user)
    user.admin?
  end
end