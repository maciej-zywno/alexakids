class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :game_id, null: false
      t.string :question, null: false
      t.integer :answer_type, null: false, default: 0

      t.timestamps null: false
    end
  end
end
