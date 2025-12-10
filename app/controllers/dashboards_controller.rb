class DashboardsController < ApplicationController
  before_action :authenticate_confirmed_user!


  def index
    @active_events_count = Event.active_events.count
    @ambulance_resource_available = 6
    @rescue_resource_available = 4
    @hospital_resource_available = 78
    @institutions_available = 10
  end
end
