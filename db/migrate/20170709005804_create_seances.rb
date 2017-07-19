class CreateSeances < ActiveRecord::Migration[5.0]
  def change
    create_table :seances do |t|

      t.timestamps
    end
  end
end
