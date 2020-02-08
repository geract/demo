class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
<<<<<<< HEAD
  devise :database_authenticatable, :rememberable, :validatable
=======
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organizations
>>>>>>> Add new model of organization and organization address and the controllers
end
