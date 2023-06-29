class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  
  def index
    @reports = Report.all
  end

  private
  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end
end