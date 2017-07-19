class AddFiedsToClients < ActiveRecord::Migration[5.0]
  def change
  	change_table :clients do |t|
		t.date :birthdate
		t.string :is_moscow
  	end
  end
end
