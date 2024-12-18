class EventsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_event, only: %w[show edit update destroy rsvp cancel_rsvp accept_co_host decline_co_host]
  # before_action :restrict_account, only: %[edit update destroy]

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
    @current_account_rsvp_status = @event.rsvps.find_by(account: current_account)&.status
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

  def rsvp
    rsvp = @event.rsvps.find_or_initialize_by(account: current_account)
    if rsvp.update(rsvp_params)
      respond_to do |format|
        format.html { redirect_to @event, notice: 'Your RSVP was successfully updated.' }
        # format.turbo_stream { flash.now[:notice] = "Your RSVP was successfully updated." }
      end
    else
      redirect_to @event, alert: 'There was an error updating your RSVP.'
    end
  end

  def cancel_rsvp
    rsvp = @event.rsvps.find_by(account: current_account)
    if rsvp&.destroy
      redirect_to @event, notice: 'Your RSVP was successfully canceled.'
    else
      redirect_to @event, alert: 'There was an error canceling your RSVP.'
    end
  end

  def interested
    @events = Event.joins(:rsvps).where(rsvps: { account: current_account, status: :interested }).ordered
  end

  def going
    @events = Event.joins(:rsvps).where(rsvps: { account: current_account, status: :going }).ordered
  end

  def past_events

  end

  def accept_co_host
    @co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
    if @co_host&.pending?
      @co_host.update(status: :accepted)
      # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has accepted the co-host invitation for the event: #{@event.name}", :co_host_accepted)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "Co-host invitation accepted." }
        format.turbo_stream { flash.now[:notice] = "Co-host invitation accepted." }
      end
    else
      redirect_to event_path(@event), alert: "Unable to accept co-host invitation."
    end
  end

  def decline_co_host
    @co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
    if @co_host&.pending?
      @co_host.increment!(:decline_count)
      @co_host.update(status: :declined)
      # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has declined the co-host invitation for the event: #{@event.name}", :co_host_declined)
      respond_to do |format|
        format.html { redirect_to event_path(@event), notice: "Co-host invitation declined." }
        format.turbo_stream { flash.now[:notice] = "Co-host invitation declined." }
      end
    else
      redirect_to event_path(@event), alert: "Unable to decline co-host invitation."
    end
  end

  def co_host_invites
    @event_co_hosts = current_account.event_co_hosts.order(status: :asc)
    @status = params[:status]

    if @status.present? && @event_co_hosts.statuses.keys.include?(@status)
      @event_co_hosts = @event_co_hosts.by_status(@status)
    end

    @pagy, @event_co_hosts = pagy_countless(@event_co_hosts, limit: 16)
  end

  private

  def event_params
    params.fetch(:event, {}).permit(:name, :details, :start_date, :end_date, :start_time, :end_time, :streaming_link, :status, :cost_type, :event_type, :country, :state, :city, :time_zone, :street_address, :category_id, :image, :location, :streaming_platform)
  end

  def find_event
    @event = Event.includes(:rsvps, :accounts).find(params[:id])
  end

  def rsvp_params
    params.require(:rsvp).permit(:status, :event_id)
  end

  def restrict_account
    unless current_account == @event.account
      redirect_to dashboard_events_url, notice: 'Access denied!'
    end
  end
end
