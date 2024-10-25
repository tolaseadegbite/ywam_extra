class Dashboard::PodcastsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_podcast, only: %w[show edit update destroy]

  def index
    @podcasts = current_account.podcasts.includes(:account).ordered
  end

  def show
    @episodes = @podcast.episodes
  end

  def edit
    
  end

  def update
    
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
end