class Medication < ApplicationRecord
    validates :name, presence: true
    validates :is_current, presence: true
    belongs_to :user
end