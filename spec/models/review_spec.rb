require 'rails_helper'


RSpec.describe Review, type: :model do
  describe "validates values" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :content}
    it {should validate_presence_of :rating}

  end

  it "assigns an image if none is given" do
    shelter = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    review = shelter.reviews.create(title: "my title", content: "my content", rating: "my rating", image: "")
    images = ["https://reallifeartist.files.wordpress.com/2011/07/garfield-comic-strip-example.png","https://www.doggo.com/wp-content/uploads/2018/02/theycantalk-FI.png","https://mutts.com/wp-content/uploads/2016/09/020416.gif", "https://www.cartoonistgroup.com/properties/speedbump/art_images/sb1051204_lr.jpg", "https://mir-s3-cdn-cf.behance.net/project_modules/disp/4e580610140389.560e007145f42.png"]

    expect(review.image.empty?).to eq(true)
    review.assign_random_image

    expect(review.save).to eq(true)
    expect(images.include?(review.image)).to eq(true)

  end

end
