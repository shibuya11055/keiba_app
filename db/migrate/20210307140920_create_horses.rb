class CreateHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :horses, id: :bigint, unsigned: true do |t|
      t.string :name, limit: 10, null: false
      t.integer :gender, null: false
      t.date :birthday, null: false
      t.integer :jockey_id, null: false

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
