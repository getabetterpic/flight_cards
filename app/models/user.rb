class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :role, presence: true
  validates :role, inclusion: %w[flier rso lco launch_admin]

  has_many :flight_cards
  has_many :launches, foreign_key: :admin_id

  def launch_admin?
    role&.to_sym == :launch_admin
  end
end
