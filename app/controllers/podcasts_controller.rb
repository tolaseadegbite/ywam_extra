class PodcastsController < ApplicationController
  before_action :authenticate_account!, except: %w[index show]
  before_action :find_podcast, only: %w[show edit update destroy]

  def index
    @podcasts = Podcast.all.includes(:account).ordered
  end

  def show
    @episodes = @podcast.episodes.ordered
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = current_account.podcasts.build(podcast_params)

    if @podcast.save
      respond_to do |format|
        format.html { redirect_to @podcast, notice: "Podcast created successfully" }
        format.turbo_stream { flash.now[:notice] = 'Podcast created successfully' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
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
