class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string  :code
      t.string  :name
      t.string  :type
      t.float   :longitude
      t.float   :latitude
      t.float   :area
      t.string  :abbr
      t.integer :postal
      t.string  :area_code
      t.string  :level

      t.timestamps
    end
    
    add_index :districts, [:code], unique: true
  end
end
