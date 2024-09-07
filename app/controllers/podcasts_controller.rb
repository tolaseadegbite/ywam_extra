class PodcastsController < ApplicationController
  before_action :authenticate_account!, except: %w[index show]
  before_action :find_podcast, only: %w[show edit update destroy]

  def index
    @podcasts = Podcast.all.includes(:account).order(id: :desc)
  end

  def show
    
  end

  def new
    @podcast = Podcast.new
  end

  def create
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

    def find_podcast
      @podcast = Podcast.find(params[:id])
    end
end
