require 'find'

namespace :webfs do
  task :load => :environment do
    dirs = YAML.load_file(File.expand_path('config/webfs.yml', Rails.root))
    dirs.each do|dir|
      Find.find(dir) do|path|
        unless File.directory?(path)
          dir, base = File.split(path)
          s = File.stat(path)
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
          ext = File.extname(path)
          basename = File.basename(path, ext)
          inode = Inode.create(
            name: basename, 
            content_type: Mime.fetch(ext[/\w+/]){|fallback| "unknown/#{fallback}" }.to_s, 
            uri: path,
            size: s.size
          ) 
        end
      end
    end
  end
  
  task :shasum => :environment do
    Inode.all.each do|resource| 
      ChecksumWorker.perform_async(resource.id) unless resource.shasum
    end
  end
end