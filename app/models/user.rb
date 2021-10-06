class User < ApplicationRecord
    attr_accessor :skip_validations
    has_many :tasks, dependent: :destroy
    # validate :name
    validates :email, presence: true, length: { maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
    before_validation {email.downcase!}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, unless: :skip_validations
    def current_user
      session[:user_id]
    end
end
