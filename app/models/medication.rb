class Medication < ApplicationRecord
    validates :name, presence: true
    validates :is_current, inclusion: { in: [true, false] }
    belongs_to :user
end