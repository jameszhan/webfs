class ShasumWorker
  include Sidekiq::Worker

  def perform(id)
    resource = Resource.find(id)
    begin
      str = `shasum '#{resource.uri}'`
      checksum = str.split[0]
      resource.update(checksum: checksum)
    rescue Exception => e
      puts "path => #{resource.uri} error: #{e.message}"
      puts e.backtrace
    end
  end
end
