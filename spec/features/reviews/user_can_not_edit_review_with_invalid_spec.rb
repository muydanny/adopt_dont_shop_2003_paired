# require 'rails_helper'
#
# RSpec.describe "When I fail to enter a title, a rating, and/or content in edit review" do
#   it "I see a flash message indicating that I need to fill in form" do
#     shelter = create(:shelter)
#     review
#     pet = create(:pet, shelter: shelter)
#
#     visit "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
#     expect(find_button("Edit Review")).to be_truthy
#
#     expect(current_path).to eq("/shelters/#{shelter.id}/new_review")
#
#     fill_in :review_title, with: "This place rocks!"
#
#     click_button("Submit")
#     expect(current_path).to eq("/shelters/#{shelter.id}/new_review")
#     expect(page).to have_content("Please fill out entire form")
#   end
# end

# When I fail to enter a title, a rating, and/or content
# in the edit shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title,
# rating, and content in order to edit a shelter review
# And I'm returned to the edit form to edit that review
