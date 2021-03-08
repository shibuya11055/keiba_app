class Traner < ApplicationRecord
  acts_as_paranoid

  has_many :horses
end
