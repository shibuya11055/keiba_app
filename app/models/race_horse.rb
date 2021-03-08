class RaceHorse < ApplicationRecord
  acts_as_paranoid

  belongs_to :horse
  belongs_to :race
  belongs_to :jockey
end
