class Dashboard::EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end

  def show
    
  end

  def new
    
  end

  def create
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def event_params
    params.require(:event).permit(:name, :details, :start_date, :end_date, :start_time, :end_time, :streaming_link, :status, :cost_type, :event_type, :country, :state, :city)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
