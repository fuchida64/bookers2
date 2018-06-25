class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { in: 2..20 }
  validates :introduction,    length: { maximum: 50 }

  has_many :posts

  attachment :profile_image

  def posts
  	return Post.where(user_id: self.id)
  end
end
