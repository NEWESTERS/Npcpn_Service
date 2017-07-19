class AddUserFields < ActiveRecord::Migration[5.0]
  def change
	change_table :users do |t|
		t.string :role
		t.string :username
  	end
  end
end
