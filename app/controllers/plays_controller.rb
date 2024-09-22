class PlaysController < ApplicationController
  before_action :authenticate_account!
  before_action :set_episode_and_podcast
  before_action :set_play, only: [:destroy]

  def create
    @play = current_account.plays.find_or_initialize_by(play_params)
    @play.account = current_account

    if @play.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @play.episode)) }
        format.turbo_stream do
          flash.now[:notice] = 'Marked as played!'
          render_turbo_update
        end
      end
    else
      handle_error
    end
  end  

  def destroy
    @play.destroy
    respond_to do |format|
      flash[:notice] = "Marked as unplayed!"
      format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @episode)) }
      format.turbo_stream do
        flash.now[:notice] = 'Marked as unplayed!'
        render_turbo_update
      end
    end
  end

  private

  def play_params
    params.require(:play).permit(:episode_id)
  end

  def set_play
    @play = current_account.plays.find(params[:id])
  end

  def set_episode_and_podcast
    @episode = Episode.find(params[:episode_id])
    @podcast = Podcast.find(params[:podcast_id])
  end

  def render_turbo_update
    render turbo_stream: turbo_stream.update('mark_as_played', 
      partial: 'plays/play_unplay', 
      locals: { podcast: @podcast, episode: @play.episode, play: @play })
  end

  def handle_error
    respond_to do |format|
      format.html { redirect_back(fallback_location: podcast_episode_path(@podcast, @play&.episode)) }
      format.json { render json: { error: @play.errors.full_messages.to_sentence }, status: :unprocessable_entity }
    end
  end
end
