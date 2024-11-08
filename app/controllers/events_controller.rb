class EventsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_event, only: %w[show edit update destroy]
  before_action :restrict_account, only: %[show]

  def index
    @events = Event.all.includes(:account).published.ordered

    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @events = current_account.events.where("LOWER(name) LIKE ? OR LOWER(details) LIKE ?", search_query, search_query)
    end

    @pagy, @events = pagy(@events, limit: 16)
  end

  def new
    @event = Event.new(event_params)
  end

  def create
    @event = current_account.events.build(event_params)

    if @event.save
      respond_to do |format|
        format.html { redirect_to event_url(@event), notice: "Event created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Event created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @events = Event.all.limit(3).ordered
  end

  def edit
    
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to event_url(@event), notice: "Event updated successfully" }
        format.turbo_stream { flash.now[:notice] = "Event updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event deleted successfully" }
    end
  end

  private

  def event_params
    params.fetch(:event, {}).permit(:name, :details, :start_date, :end_date, :start_time, :end_time, :streaming_link, :status, :cost_type, :event_type, :country, :state, :city, :time_zone, :street_address, :category_id, :image, :location, :streaming_platform)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def restrict_account
    unless current_account == @event.account
      redirect_to dashboard_events_url, notice: 'Access denied!'
    end
  end
end
