class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	has_many :replies , dependent: :destroy
	validates_presence_of :content
end
