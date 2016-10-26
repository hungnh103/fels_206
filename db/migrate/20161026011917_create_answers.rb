class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct
      t.integer :word_id

      t.timestamps
    end
  end
end
