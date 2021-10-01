class Task < ApplicationRecord
    validates :name, presence: true
    validates :details, presence: true
    validates :expired_at, presence: true
end
