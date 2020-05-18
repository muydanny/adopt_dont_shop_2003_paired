class Favorite
  # has_many :pets
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    #this is ruby, and it was in the lesson?
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def favorite_pets
    # need to chagne this to AR instead of RUBY
    # this IS using AR... currently @contents is not an AR object
    @contents.keys.map {|id| Pet.find(id)}
  end
end
