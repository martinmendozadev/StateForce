# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_confirmed_user!

  before_action :set_event

  def show
    # Expose @event to the view
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
