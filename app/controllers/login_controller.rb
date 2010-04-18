class LoginController < ApplicationController
  def login
    session[:admin] = true  if params[:password] == APP_CONFIG[:password]
    redirect_to cameras_path
  end

  def logout
    session[:admin] = nil;
    redirect_to cameras_path
  end
end