class DashboardsController < ApplicationController
  before_action :authenticate_confirmed_user!


  def index
  end
end
