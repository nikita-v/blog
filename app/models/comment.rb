class Comment < ActiveRecord::Base
  include Authority::Abilities
  belongs_to :user
  belongs_to :post

  validates :text, presence: true
end
