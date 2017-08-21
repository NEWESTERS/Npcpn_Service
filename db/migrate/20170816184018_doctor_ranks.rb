class DoctorRanks < ActiveRecord::Migration[5.0]
  def change
  	change_table :doctors do |t|
		t.string :rank
  	end
  end
end
