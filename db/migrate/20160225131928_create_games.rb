class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.string :invocation, null: false

      t.timestamps null: false
    end
  end
end
