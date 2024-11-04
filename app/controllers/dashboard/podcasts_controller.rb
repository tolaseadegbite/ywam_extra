class Dashboard::PodcastsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_podcast, only: %w[show edit update destroy]
  before_action :restrict_user, only: %[show]

  def index
    @podcasts = current_account.podcasts.includes(:account).ordered

    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @podcasts = current_account.podcasts.where("LOWER(name) LIKE ? OR LOWER(about) LIKE ?", search_query, search_query)
    end

    @pagy, @podcasts = pagy(@podcasts, limit: 3)
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = current_account.podcasts.build(podcast_params)

    if @podcast.save
      respond_to do |format|
        format.html { redirect_to dashboard_podcast_url(@podcast), notice: "Podcast created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Podcast created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @episodes = @podcast.episodes.includes(:podcast).desc
    
    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @episodes = @episodes.where("LOWER(title) LIKE ? OR LOWER(description) LIKE ?", search_query, search_query)
    end

    @pagy, @episodes = pagy(@episodes, limit: 5)
  end

  def edit
    
  end

  def update
    if @podcast.update(podcast_params)
      respond_to do |format|
        format.html { redirect_to dashboard_podcast_url(@podcast), notice: "Podcast updated successfully" }
        format.turbo_stream { flash.now[:notice] = "Podcast updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_podcasts_url, notice: "Podcast deleted successfully" }
    end
  end

  private

    def podcast_params
      params.require(:podcast).permit(:name, :about, :cover_art, :category_id, tag_ids: [])
    end

    def find_podcast
      @podcast = Podcast.find(params[:id])
    end

    def restrict_user
      unless current_account == @podcast.account
        redirect_to dashboard_podcasts_url, notice: 'Access denied!'
      end
    end
end