require "test_helper"

describe Vote do
  before do 
    @new_user = User.create(user_name: "Junito the Burrito")
    @new_work1 = Work.create(
      category: "album",
      title: "June Bug",
      creator: "Test Person", 
      publication_year: 2020,
      description: "Squirrel spin bulldog bark leash dog bone"
    )
    @new_vote = Vote.new(user_id: new_user.id, work_id: new_work1.id)
  end 

  it "can be instantiated" do
    # Assert
    expect(@new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    @new_vote.save
    vote = Vote.first
    [:user_id, :work_id].each do |field|
      # Assert
      expect(vote).must_respond_to field
    end
  end

  # relationships 
  # belongs_to :user
  # belongs_to :work
  describe "relationships" do 
    it "belongs to user" do 
      
    end 
    it "belongs to work" do 

    end 
  end 

  # validations 
  # validates :user, uniqueness: {scope: [:work], message: "already voted for this work"}
  describe "validations" do 
    it "is invalid without user_id" do
      @new_vote.user_id = nil
      expect(@new_vote.valid?).must_equal false
    end

    it "is invalid without work_id" do
      @new_vote.work_id = nil
      expect(@new_vote.valid?).must_equal false
    end
  end
end
