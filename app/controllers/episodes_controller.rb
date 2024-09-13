class EpisodesController < ApplicationController
  before_action :authenticate_account!, only: %w[create edit update destroy]
  before_action :find_episode, only: %w[edit update destroy]
  before_action :find_podcast

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
        format.html { redirect_to @podcast, notice: "Episode updated successfully" }
        format.turbo_stream { flash.now[:notice] = "Episode updated successfully" }
      end
    else
      render :edit
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

    def episode_params
      params.require(:episode).permit(:title, :description, :episode_type, :cover_art, :category_id, tag_ids: [])
    end

    def find_podcast
      @podcast = Podcast.find(params[:podcast_id])
    end

    def find_episode
      @episode = Episode.find(params[:id])
    end
end
