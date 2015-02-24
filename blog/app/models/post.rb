class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments , dependent: :destroy
	has_many :replies  , dependent: :destroy
	validates_presence_of :title , :content

end
