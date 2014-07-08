class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :mark_user


  def mark_user
    cookies[:user_id] = current_user.uid if cookies[:user_id].nil?
  end

  def current_user
    @current_user = @current_user || save_user
  end


  def can_manage resource
    current_user.id == resource.user_id
  end

  helper_method :can_manage



  private

  def save_user
    uniq_id = cookies[:user_id] || generate_uniq_id
    User.find_or_create_by(
        :ip => request.remote_ip,
        :uid => uniq_id
    )
  end

  def generate_uniq_id
    (5...30).sort_by{rand}.join
  end

end
