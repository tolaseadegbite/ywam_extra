class Dashboard::EpisodesController < ApplicationController
  before_action :authenticate_account!, except: %w[show]
  before_action :find_episode, only: %w[show edit update destroy]
  before_action :find_podcast

  def new
    @episode = Episode.new
  end

  def create
    @episode = @podcast.episodes.build(episode_params)

    if @episode.save
      respond_to do |format|
        format.html { redirect_to dashboard_podcast_url(@podcast), notice: "Episode created successfully" }
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
        format.html { redirect_back(fallback_location: dashboard_podcast_episode_url(@podcast, @episode), notice: "Podcast updated successfully") }

        format.turbo_stream { flash.now[:notice] = "Episode updated successfully" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    
  end

  private

    # def ensure_frame_response
    #   redirect_to root_path unless turbo_frame_request?
    # end

    def episode_params
      params.require(:episode).permit(:title, :description, :episode_type, :cover_art, :audio, :status, :category_id, tag_ids: [])
    end

    def find_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    def find_episode
      @episode = Episode.find(params[:id])
    end

end
