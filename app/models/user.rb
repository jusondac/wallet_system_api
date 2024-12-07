class User < ApplicationRecord
  has_secure_password
  has_one :wallet, as: :entity, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum:6, maximum:18}
end
