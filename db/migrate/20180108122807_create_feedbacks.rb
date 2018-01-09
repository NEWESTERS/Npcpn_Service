class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :last_name
      t.string :patronymic
      t.string :email
      t.string :theme
      t.text :text

      t.timestamps
    end
  end
end
