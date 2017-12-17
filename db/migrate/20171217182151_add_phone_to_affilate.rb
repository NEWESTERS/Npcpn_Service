class AddPhoneToAffilate < ActiveRecord::Migration[5.0]
  def change
  	change_table :affilates do |t|
      t.string :phone
    end
  end
end
