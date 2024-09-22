class PlaylistsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  def index
    @playlists = current_account.playlists.ordered
  end

  def show
    
  end

  def new
    @playlist = Playlist.new
  end
  
  def create
    @playlist = current_account.playlists.build(playlist_params)
    if @playlist.save
      respond_to do |format|
        format.html { redirect_to @playlist, notice: "Playlist created"}
      end
    else
      render :new
    end
  end

  def update
    if @playlist.update(playlist_params)
      respond_to do |format|
        format.html { redirect_to @playlist, notice: "Playlist updated"}
      end
    else
      render :edit
    end
  end

  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Playlist deleted"}
    end
  end

  private

    def playlist_params
      params.require(:playlist).permit(:name, :description, :photo, :visibility)
    end

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end
end
