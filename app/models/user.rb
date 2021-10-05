class User < ApplicationRecord
    has_many :tasks
    # validate :name
    validates :email, presence: true, length: { maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
    before_validation {email.downcase!}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
    def current_user
      session[:user_id]
    end
end
