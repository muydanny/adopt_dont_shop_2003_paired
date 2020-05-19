class ReviewsController < ApplicationController

  def new_review
    @review = Review.new(shelter_id: params["id"])
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @review = Review.find(params[:review_id])
    @shelter = Shelter.find(params[:id])
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
    @shelter = Shelter.find(params[:id])
    @review = @shelter.reviews.create(review_params)
    # @review = Review.create(shelter_id: shelter_id[:id])
    # @review = Review.create(review_params)
    # @review.update(review_params)

    if @review.image == ""
      @review.assign_random_image
    end

    if @review.save
      redirect_to "/shelters/#{shelter_id[:id]}", notice: "Successfully created review! Thanks dog."
    else
      redirect_to "/shelters/#{shelter_id[:id]}/new_review" , notice: "Please fill out entire form"
    end
  end

  def destroy
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter_id[:id]}", notice: "Successfully deleted review!"
  end

  private

  def review_params
    # params.require(:review).permit(:title, :rating, :content, :image)
    params.permit(:title, :rating, :content, :image)
  end

  def shelter_id
    params.permit(:id)
  end
end
