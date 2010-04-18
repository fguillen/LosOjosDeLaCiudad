class CamerasController < ApplicationController
  def index
    opts = {:geolocalized => 'true'}.merge( params.symbolize_keys() )
    @cameras = Camera.filter( opts )
  end
  
  def show
    @camera = Camera.find(params[:id])
  end
  
  def new
    @camera = Camera.new
  end
  
  def create
    @camera = Camera.new(params[:camera])
    if @camera.save
      flash[:notice] = "Successfully created camera."
      redirect_to @camera
    else
      flash[:alert] = "Algo malo ha ocurrido al intentar crear Cámara"
      render :action => 'new'
    end
  end
  
  def edit
    @camera = Camera.find(params[:id])
  end
  
  def update
    @camera = Camera.find(params[:id])
    if @camera.update_attributes(params[:camera])
      flash[:notice] = "Successfully updated camera."
      redirect_to @camera
    else
      flash[:alert] = "Algo malo ha ocurrido al intentar actualizar Cámara"
      render :action => 'edit'
    end
  end
  
  def destroy
    @camera = Camera.find(params[:id])
    @camera.destroy
    flash[:notice] = "Successfully destroyed camera."
    redirect_to cameras_url
  end
  
  def geoposition
    @camera = Camera.find(params[:id])
  end
  
  def widget
    @camera = Camera.find(params[:id])
    
    render :partial => 'widget', :locals => {:camera => @camera, :size => 'medium'}
  end
  
  def snapshot
    @camera = Camera.find(params[:id])
    
    if !params[:datetime].blank?
      @history = History.snapshot( @camera, params[:datetime] )
    else
      @history = @camera.histories.first( :order => 'date desc' )
    end
    
    if @history.nil?
      render :json => { :image_url => "/images/not_image_#{params[:size]}.jpg", :datetime => Time.parse(params[:datetime]).strftime( "%Y/%M/%d %H:%m" ) }
    else
      render :json => { :image_url => @history.image.url(params[:size].to_sym), :datetime => @history.date.strftime( "%Y/%M/%d %H:%m" ) }
    end
  end
end
