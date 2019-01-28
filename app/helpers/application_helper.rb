module ApplicationHelper
  def current_user_is_admin?
    params[:admin] == 'true'
  end
end
