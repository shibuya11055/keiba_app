class CreateRaceHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :race_horses, id: :bigint, unsigned: true do |t|
      t.references :horse, foreign_key: true
      t.references :race, foreign_key: true
      t.references :jockey, foreign_key: true
      t.integer :ranking, comment: '順位'
      t.integer :post_position, comment: '枠順'
      t.integer :horse_order, comment: '馬順'

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
