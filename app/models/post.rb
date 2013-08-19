class Post < ActiveRecord::Base
  include Authority::Abilities
  belongs_to :user
  has_many :comments

  validates_presence_of :title, :short_body

  default_scope {order(id: :desc)}
end
