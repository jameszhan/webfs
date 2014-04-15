class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :aliases, array: true, default: '{}'

      t.timestamps
    end
  end
end
