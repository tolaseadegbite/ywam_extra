class TagsController < ApplicationController
  before_action :authenticate_account!, only: %i[ create ]

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    if @tag.valid?
      @tag.save
      render json: @tag
    else
      flash[:notice] = @tag.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path, status: :unprocessable_entity)
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name)
    end

end
