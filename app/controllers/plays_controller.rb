class PlaysController < ApplicationController
  before_action :authenticate_account!
  before_action :set_play, only: [:destroy]
  before_action :set_episode, only: [:destroy]
  before_action :set_podcast

  def create
    @play = current_account.plays.build(play_params)
    @play.account = current_account
    if @play.save
      respond_to do |format|
        flash[:notice] = "Mark as played!"
        format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @play.episode)) }
        format.turbo_stream { flash.now[:notice] = 'Mark as played!' } 
      end
    else
      flash[:notice] = @play.errors.full_messages.to_sentence
    end
  end

  def destroy
    @play.destroy
    respond_to do |format|
      flash[:notice] = "Mark as unplayed!"
      format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @episode)) } 
      format.turbo_stream { flash.now[:notice] = 'Mark as unplayed!' } 
    end
  end

  private

  def play_params
    params.require(:play).permit(:episode_id)
  end

  def set_play
    @play = current_account.plays.find(params[:id])
  end

  def set_episode
    @episode = Episode.find(params[:episode_id])
  end

  def set_podcast
    @podcast = Podcast.find(params[:podcast_id])
  end
end
