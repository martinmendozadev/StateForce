class DashboardsController < ApplicationController
  before_action :authenticate_confirmed_user!


  def index
    # Dashboard Resume (stats)
    @active_events_count = Event.active_events.count
    @ambulance_resource_available = Resource.vehicles_resource_available "Ambulance"
    @rescue_resource_available = Resource.vehicles_resource_available "Fire Truck"
    @hospital_resource_available = Resource.percentage_hospitals_beds_available
    @institutions_available = Institution.active_institutions.count

    # Recent Events
    @last_events = Event.last_events
  end
end
