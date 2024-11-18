class Dashboard::EventsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_event, only: %w[show edit update destroy add_co_host remove_co_host accept_co_host decline_co_host]
  # before_action :restrict_account, only: %[show edit update destroy]

  def index
    @events = current_account.events.includes(:account).ordered

    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @events = current_account.events.where("LOWER(name) LIKE ? OR LOWER(details) LIKE ?", search_query, search_query)
    end

    @pagy, @events = pagy(@events, limit: 10)
  end

  def new
    @event = Event.new(event_params)
  end

  def create
    @event = current_account.events.build(event_params)

    if @event.save
      respond_to do |format|
        format.html { redirect_to dashboard_event_url(@event), notice: "Event created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Event created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event_co_hosts = @event.event_co_hosts.order(status: :asc)
    accepted_co_hosts = @event.event_co_hosts.accepted.map(&:account)
    declined_too_many_times = @event.event_co_hosts.where('decline_count > ?', 3).map(&:account)
    @accounts = Account.all - accepted_co_hosts - declined_too_many_times
  end

  def edit
    
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to dashboard_event_url(@event), notice: "Event updated successfully" }
        format.turbo_stream { flash.now[:notice] = "Event updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_events_url, notice: "Event deleted successfully" }
    end
  end

  def add_co_host
    account = Account.find(params[:account_id])
    @co_host = @event.event_co_hosts.find_or_initialize_by(account: account)

    if @co_host.decline_count > 3
      redirect_to dashboard_event_path(@event), alert: "This account has declined too many co-host invitations and cannot be added again."
    else
      @co_host.status = :pending
      if @co_host.save
        respond_to do |format|
          # NotificationJob.perform_later(account, @event, "You have been added as a co-host to the event: #{@event.name}", :co_dashboard_added)
          format.html { redirect_to dashboard_event_path(@event), notice: "Co-host added successfully." }
          
          # format.turbo_stream { flash.now[:notice] = "Co-host added successfully." }
        end
      else
        redirect_to dashboard_event_path(@event), alert: "Unable to add co-host."
      end
    end
  end

  def remove_co_host
    account = Account.find(params[:account_id])
    @co_host = @event.event_co_hosts.find_by(account: account)
    if @co_host&.destroy
      respond_to do |format|
        # NotificationJob.perform_later(account, @event, "You have been removed as a co-host from the event: #{@event.name}", :co_dashboard_removed)
        format.html {redirect_to dashboard_event_path(@event), notice: "Co-host removed successfully."}

        format.turbo_stream { flash.now[:notice] = "Co-host removed successfully." }
      end
    else
      redirect_to dashboard_event_path(@event), alert: "Unable to remove co-host."
    end
  end

  def accept_co_host
    co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
    if co_host&.pending?
      co_host.update(status: :accepted)
      # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has accepted the co-host invitation for the event: #{@event.name}", :co_dashboard_accepted)
      redirect_to dashboard_event_path(@event), notice: "Co-host invitation accepted."
    else
      redirect_to dashboard_event_path(@event), alert: "Unable to accept co-host invitation."
    end
  end

  def decline_co_host
    co_host = @event.event_co_hosts.find_by(account_id: params[:account_id])
    if co_host&.pending?
      co_host.increment!(:decline_count)
      co_host.update(status: :declined)
      # NotificationJob.perform_later(@event.account, @event, "#{co_host.account.accountname} has declined the co-host invitation for the event: #{@event.name}", :co_dashboard_declined)
      redirect_to dashboard_event_path(@event), notice: "Co-host invitation declined."
    else
      redirect_to dashboard_event_path(@event), alert: "Unable to decline co-host invitation."
    end
  end

  private

  def event_params
    params.fetch(:event, {}).permit(:name, :details, :start_date, :end_date, :start_time, :end_time, :streaming_link, :status, :cost_type, :event_type, :country, :state, :city, :time_zone, :street_address, :category_id, :image, :location, :streaming_platform, :booking_url, :audience)
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
