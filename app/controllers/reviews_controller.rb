class ReviewsController < ApplicationController

  def new_review
    @review = Review.new(shelter_id: params["id"])
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params)
      redirect_to "/shelters/#{shelter_id[:id]}", notice: "Successfully edited review! Thanks dog."
    else
      redirect_to "/shelters/#{shelter_id[:id]}/reviews/#{review.id}/edit" , notice: "Please fill out entire form"
    end
  end

  def create
    @review = Review.create(shelter_id: shelter_id[:id])
    @review.update(review_params)
    if @review.save
      redirect_to "/shelters/#{shelter_id[:id]}", notice: "Successfully created review! Thanks dog."
    else
      redirect_to "/shelters/#{shelter_id[:id]}/new_review" , notice: "Please fill out entire form"
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
