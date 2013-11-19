json.array!(@inodes) do |inode|
  json.extract! inode, :shasum, :uri, :size, :content_type, :name
  json.url inode_url(inode, format: :json)
end
