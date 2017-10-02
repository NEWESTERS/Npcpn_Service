class CreateAffilates < ActiveRecord::Migration[5.0]
  def change
    create_table :affilates do |t|
      t.string :address
      t.string :name
      t.timestamps
    end

    change_table :doctors do |t|
      t.belongs_to :affilate, index: true
    end

    change_table :seances do |t|
      t.belongs_to :affilate, index: true
    end

    change_table :users do |t|
      t.belongs_to :affilate, index: true
    end
  end
end
