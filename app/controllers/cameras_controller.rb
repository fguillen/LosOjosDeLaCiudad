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
end
