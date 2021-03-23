class Race < ApplicationRecord
  acts_as_paranoid

  belongs_to :track
  has_many :race_horses
  has_many :horses, through: :race_horses

  enum grade: {
    g_one: 0,
    g_two: 1,
    g_three: 2
  }

  enum is_finish: {
    finished: 0,
    opening: 1
  }
end
