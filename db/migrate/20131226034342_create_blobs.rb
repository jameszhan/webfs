class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|
      t.string    :digest
      t.string    :uri
      t.string    :size
      t.string    :content_type
      t.string    :name
      t.datetime  :modified_at

      t.timestamps
    end
  end
end
