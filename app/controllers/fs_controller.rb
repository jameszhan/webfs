class FsController < ActionController::Metal
  include AbstractController::Layouts
  include ActionController::DataStreaming
  include ActionController::Instrumentation
  include Rails.application.routes.url_helpers
  
  append_view_path "#{Rails.root}/app/views"
  
  def ls    
    path, ext = params[:path], params[:ext]
    ext = ".#{ext}" if ext
    @files = Dir["#{path}/*#{ext}"] || []
    render 'ls', layout: 'metal'
  end
  
  def open
    @path = params[:path]
    if File.directory?(@path)
      @files = Dir["#{@path}/*"] || []
      render :ls
    else
      render 'open', layout: 'metal'
    end
  end
  
  def download
    @path = params[:path]
    send_file @path, type: "application/octet-stream"
  end
  
end