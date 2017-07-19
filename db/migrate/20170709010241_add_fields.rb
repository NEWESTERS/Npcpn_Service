class AddFields < ActiveRecord::Migration[5.0]
  def change
  	change_table :clients do |t|
  		t.string :last_name
  		t.string :name 
  		t.string :patronymic
  		t.string :email
  		t.string :phone
  	end

  	change_table :doctors do |t|
  		t.string :last_name
  		t.string :name 
  		t.string :patronymic
  	end

  	change_table :seances do |t|
  		t.datetime :date
  		t.belongs_to :doctor, index: true
  		t.belongs_to :client, index: true
  	end
  end
end
