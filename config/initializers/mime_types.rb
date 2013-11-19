# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

MIMES = YAML.load_file(File.expand_path('../../mimes.yml', __FILE__))

MIMES.each do|ext, mime|
  Mime.fetch(ext) do|fallback|
    Mime::Type.register mime, ext
  end  
end
