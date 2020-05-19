class Review < ApplicationRecord
  belongs_to :shelter
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true

  def assign_random_image
    images = ["https://reallifeartist.files.wordpress.com/2011/07/garfield-comic-strip-example.png","https://www.doggo.com/wp-content/uploads/2018/02/theycantalk-FI.png","https://mutts.com/wp-content/uploads/2016/09/020416.gif", "https://www.cartoonistgroup.com/properties/speedbump/art_images/sb1051204_lr.jpg", "https://mir-s3-cdn-cf.behance.net/project_modules/disp/4e580610140389.560e007145f42.png"]
    self.image = images.shuffle.first
    self.save
  end
end
