class MenuController < ApplicationController
  before_action :auth_filter

  def auth_filter
    if current_user.nil? || current_user.email != 'admin@admin.ru'
      redirect_to root_path
    end
  end

  def view
  end
end
