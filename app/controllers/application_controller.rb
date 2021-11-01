class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_current_user

  private
  def set_current_user
    User.current = current_user
  end
end
