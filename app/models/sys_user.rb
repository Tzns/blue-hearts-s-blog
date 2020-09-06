class SysUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #attr_accessible :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :created_at, :updated_at
end
