class InodesController < ApplicationController
  before_action :set_inode, only: [:show, :edit, :update, :destroy]
  
  helper_method :sort_column, :sort_direction

  # GET /inodes
  # GET /inodes.json
  def index
    @inodes = Inode.order(sort_column + " " + sort_direction).page params[:page]
  end

  # GET /inodes/1
  # GET /inodes/1.json
  def show
  end

  # GET /inodes/new
  def new
    @inode = Inode.new
  end

  # GET /inodes/1/edit
  def edit
  end
  
  def open
    inode = Inode.find(params[:id])
    app = "Preview"
    if inode.content_type =~ /^text\/.+$/
      app = "TextMate"
    end
    system "open -a #{app} #{inode.uri}"
    redirect_to request.referer
  end
  
  def preview  
    inode = Inode.find(params[:id])  
    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = inode.content_type
    response.headers['Content-Disposition'] = 'inline'
    render text: File.read(inode.uri), content_type: content_type
  end


  # POST /inodes
  # POST /inodes.json
  def create
    @inode = Inode.new(inode_params)

    respond_to do |format|
      if @inode.save
        format.html { redirect_to @inode, notice: 'Inode was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inode }
      else
        format.html { render action: 'new' }
        format.json { render json: @inode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inodes/1
  # PATCH/PUT /inodes/1.json
  def update
    respond_to do |format|
      if @inode.update(inode_params)
        format.html { redirect_to @inode, notice: 'Inode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inodes/1
  # DELETE /inodes/1.json
  def destroy
    @inode.destroy
    respond_to do |format|
      format.html { redirect_to inodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inode
      @inode = Inode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inode_params
      params.require(:inode).permit(:shasum, :uri, :size, :content_type, :name)
    end

    def sort_column
      Inode.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
