class RaceHorse < ApplicationRecord
  acts_as_paranoid

  belongs_to :horse
  belongs_to :race
  belongs_to :jockey

  def set_post_position(order)
    case order
    when 1, 2
      1
    when 3, 4
      2
    when 5, 6
      3
    when 7, 8
      4
    when 9, 10
      5
    when 11, 12
      6
    when 13, 14
      7
    when 15, 16
      8
    end
  end
end
