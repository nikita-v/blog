class User < ActiveRecord::Base
  include Authority::UserAbilities
  include Gravtastic
  gravtastic size: 64

  has_many :posts
  has_many :comments
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w(user admin) }, allow_nil: true

  def admin?
    self.role == 'admin'
  end

  def user?
    self.role == 'user'
  end
end
