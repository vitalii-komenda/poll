class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user = @current_user || User.find_or_create_by(:ip => request.remote_ip)
  end


  def can_manage resource
    current_user.id == resource.user_id
  end


  helper_method :can_manage

end
