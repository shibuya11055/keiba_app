class Horse < ApplicationRecord
  acts_as_paranoid

  belongs_to :traner
  has_many :race_horses

  enum gender: {
    male: 0,
    female: 1
  }
end
