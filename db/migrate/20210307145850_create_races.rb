class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races, id: :bigint, unsigned: true do |t|
      t.string :name, null: false
      t.datetime :event_date, null: false
      t.integer :track_id, null: false
      t.integer :grade, null: false, comment: '0: g1, 1: g2, 2: g3'
      t.integer :is_finish, null: false, comment: '0: finish, 1: opening'

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
