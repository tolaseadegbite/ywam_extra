class PodcastsController < ApplicationController
  before_action :authenticate_account!, except: %w[index show]
  before_action :find_podcast, only: %w[show edit update destroy]

  def index
    # @podcasts = Podcast.all.includes(:account).ordered
    # @pagy, @podcasts = pagy_countless(@podcasts, limit: 12)

    # sort_order = params[:sort] || 'ordered'
    # @podcasts = Podcast.all.includes(:account).public_send(sort_order)
    @podcasts = Podcast.all.includes(:account).ordered
    
    if params[:search].present?
      search_query = "%#{params[:search].downcase}%"
      @podcasts = @podcasts.where("LOWER(name) LIKE ? OR LOWER(about) LIKE ?", search_query, search_query)
    end
  
    @pagy, @podcasts = pagy(@podcasts, limit: 12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @episodes = @podcast.episodes.where(status: :published).recent(5)
    @reviews = @podcast.reviews.includes(:account).ordered
    @review = Review.new
    @play = Play.new
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = current_account.podcasts.build(podcast_params)

    if @podcast.save
      respond_to do |format|
        format.html { redirect_to @podcast, notice: "Podcast created successfully" }
        # format.turbo_stream { flash.now[:notice] = 'Podcast created successfully' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @podcast.update(podcast_params)
      respond_to do |format|
        format.html { redirect_to @podcast, notice: "Podcast updated successfully" }
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
end
