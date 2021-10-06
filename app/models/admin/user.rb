class Admin::User < ApplicationRecord
    attr_accessor :skip_validations

    validates :password, presence: true, length: {minimum: 6}, unless: :skip_validations

    paginates_per 5
    
end
