require 'shellwords'

class ShasumWorker
  include Sidekiq::Worker

  def perform(id)
    inode = Inode.find(id)
    begin
      logger.info { "shasum \"#{escape(inode.uri)}\"" }
      str = `shasum "#{escape(inode.uri)}"`
      checksum = str.split[0]
      inode.update(shasum: checksum)
    rescue Exception => e
      logger.error "path => #{escape(inode.uri)} error: #{e.message}"
      logger.error e.backtrace
    end
  end
  
  def escape(str)
    str
  end
end
