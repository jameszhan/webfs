require 'find'

namespace :webfs do
  task :load => :environment do
    dirs = YAML.load_file(File.expand_path('config/webfs.yml', Rails.root))
    dirs.each do|dir|
      Find.find(dir) do|path|
        unless File.directory?(path)
          dir, base = File.split(path)
          s = File.stat(path)
=begin          
          stat = {
            :access_time => s.atime, 
            :created_time => s.ctime,
            :modified_time => s.mtime,
            :size => s.size,
            :inode => s.ino,
            :hardlink_count => s.nlink,
            :type => s.ftype,
            :mode => s.mode
          }
=end
          ext = File.extname(path)
          basename = File.basename(path, ext)
          Blob.create(
            name: basename, 
            content_type: Mime.fetch(ext[/\w+/]){|fallback| "unknown/#{fallback}" }.to_s, 
            uri: path,
            size: s.size,
            created_at: s.ctime,
            modified_at: s.mtime
          ) 
        end
      end
    end
  end
  
  task :digest => :environment do
    Blob.all.each do|blob|       
      DigestWorker.perform_async(blob.id) if DigestWorker.accept?(blob)
    end
  end
end