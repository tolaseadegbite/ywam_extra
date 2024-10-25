class Dashboard::PodcastsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_podcast, only: %w[show edit update destroy]
  before_action :restrict_user, only: %[show]

  def index
    @podcasts = current_account.podcasts.includes(:account).ordered
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
    @episodes = @podcast.episodes
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
        redirect_to dashboard_podcast_url, notice: 'Access denied!'
      end
    end
end