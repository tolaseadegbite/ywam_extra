class ReviewsController < ApplicationController
  before_action :set_reviewable
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = @reviewable.reviews
  end

  def new
    @review = Review.new
  end

  def create
    @review = @reviewable.reviews.build(review_params)
    @review.account = current_account
  
    if @review.save
      respond_to do |format|
        format.html { redirect_to @reviewable, notice: 'Review was successfully created.' }
        format.turbo_stream
      end
    else
      # Handle the error and re-render the form
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = @review.errors.full_messages.join(", ")
          render turbo_stream: turbo_stream.replace('new_review', partial: 'reviews/form', locals: { review: @review, reviewable: @reviewable })
        end
      end
    end
  end
  
  def show
    
  end

  def edit
    
  end

  def update
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to @reviewable, notice: 'Review was successfully updated.' }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @reviewable, notice: "Review deleted." }
      format.turbo_stream
    end
  end

  private

  def set_reviewable
    @reviewable = if params[:product_id]
                    Product.find(params[:product_id])
                  elsif params[:podcast_id]
                    Podcast.find(params[:podcast_id])
                  end
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end