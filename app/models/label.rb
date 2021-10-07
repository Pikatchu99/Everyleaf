class Label < ApplicationRecord
    validates :name, presence: {message: "important"}
    
    
    has_many :labelings, dependent: :destroy
    has_many :tasks, through: :labelings, source: :task


    
end
