class Track < ApplicationRecord
  acts_as_paranoid

  has_many :races

  enum field_type: {
    turf: 0,
    dirt: 1
  }
end
