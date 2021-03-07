class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks, id: :bigint, unsigned: true do |t|
      t.string :name, null: false
      t.integer :field_type, null: false, default: 0, comment: '0: turf(芝), 1: dirt(ダート)'
      t.integer :field_range, null: false, comment: '距離'

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
