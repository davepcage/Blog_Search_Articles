class User < ApplicationRecord
  has_many :comments
  has_many :blogs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 180

end
