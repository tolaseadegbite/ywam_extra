class EpisodesController < ApplicationController
  before_action :authenticate_account!, only: %w[create edit update destroy]
  before_action :find_episode, only: %w[show edit update destroy]
  before_action :find_podcast

  def index
    @episodes = @podcast.episodes.ordered
    @reviews = @podcast.reviews.includes(:account).ordered
    @review = Review.new
  end

  def new
    @episode = Episode.new
  end
  
  def create
    @episode = @podcast.episodes.build(episode_params)
    # @episode.account = current_account

    if @episode.save
      respond_to do |format|
        format.html { redirect_to @podcast, notice: "Episode created successfully" }
        format.turbo_stream { flash.now[:notice] = "Episode created successfully" }
      end
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @episode.update(episode_params)
      respond_to do |format|
        flash[:notice] = "Episode updated successfully"
        format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @episode)) }
        format.turbo_stream { flash.now[:notice] = "Episode updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
      # render(
      #   turbo_stream: turbo_stream.update(
      #     "episode_form",
      #     partial: "episodes/form",
      #     locals: {
      #       podcast: @podcast,
      #       episode: @episode
      #     }
      #   )
      # )
    end
  end

  def destroy
    @episode.destroy
    respond_to do |format|
      format.html { redirect_to @podcast, notice: "Episode deleted successfully" }
      format.turbo_stream { flash.now[:notice] = "Episode deleted successfully" }
    end
  end

  private

    # def ensure_frame_response
    #   redirect_to root_path unless turbo_frame_request?
    # end

    def episode_params
      params.require(:episode).permit(:title, :description, :episode_type, :cover_art, :audio, :category_id, tag_ids: [])
    end

    def find_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    def find_episode
      @episode = Episode.find(params[:id])
    end
end
