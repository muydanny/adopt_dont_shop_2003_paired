class ReviewsController < ApplicationController

  def new_review
    @review = Review.new(shelter_id: params["id"])
  end

  def create
    @review = Review.create(shelter_id: shelter_id[:id])
    @review.update(review_params)
    if @review.save
      redirect_to "/shelters/#{shelter_id[:id]}"
    else
      redirect_to "/shelters/#{shelter_id[:id]}/new_review"
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :content, :image)
  end

  def shelter_id
    params.permit(:id)
  end
end
