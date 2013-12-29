json.array!(@blobs) do |blob|
  json.extract! blob, :id, :digest, :uri, :size, :content_type, :name
  json.url blob_url(blob, format: :json)
end
