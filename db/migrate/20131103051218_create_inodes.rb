class CreateInodes < ActiveRecord::Migration
  def change
    create_table :inodes do |t|
      t.string  :digest
      t.string  :uri
      t.integer :size, limit: 8
      t.string  :content_type
      t.string  :name

      t.timestamps
    end
  end
end
