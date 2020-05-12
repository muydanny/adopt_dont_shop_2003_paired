require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validates values" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :image}
    # it {should validate_presence_of :description}
    it {should validate_presence_of :age}

  end
