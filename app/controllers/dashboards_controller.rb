class DashboardsController < ApplicationController
  before_action :authenticate_confirmed_user!


  def index
    @active_events_count = Event.active_events.count
  end
end
