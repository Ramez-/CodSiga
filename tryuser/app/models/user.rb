

class User < ActiveRecord::Base
	validates_confirmation_of :password
  validates_presence_of :email , :name , :password
  validates_uniqueness_of :email

  validates :email, email: { message: "format is invalid"}

  def self.authenticate(email , password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end

  
end
