class Jockey < ApplicationRecord
  acts_as_paranoid

  has_many :race_horses
end
