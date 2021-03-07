class CreateJockeys < ActiveRecord::Migration[6.0]
  def change
    create_table :jockeys, id: :bigint, unsigned: true do |t|
      t.string :name, null: false
      t.date :birthday, null: true # データ投入のため一旦null: true
      t.integer :registration_number, null: true # データ投入のため一旦null: true

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
