class ChecksumWorker
  include Sidekiq::Worker
  
  BUF_SIZE = 1024 * 1024 * 1024
  
  def perform(id)
    inode = Inode.find(id)
    begin
      logger.info { "checksum for \"#{escape(inode.uri)}\"" }
      checksum = checksum(inode.uri)
      inode.update(shasum: checksum)
    rescue Exception => e
      logger.error "path => #{escape(inode.uri)} error: #{e.message}"
      logger.error e.backtrace
    end
  end

  def checksum(uri)
    sha = Digest::SHA1.new
    open(uri, "rb") do|io|
      while buf = io.read(BUF_SIZE)
        sha.update(buf)
      end
    end
    sha.hexdigest
  end
    
end

