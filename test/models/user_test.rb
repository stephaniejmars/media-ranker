require "test_helper"

describe User do
  let (:new_user) {
    User.new(
      user_name: "Junito the Burrito"
    )
  }

  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    [:user_name].each do |field|
      # Assert
      expect(user).must_respond_to field
    end
  end
  #relationships 
  #user can have many votes 
  #TODO user can have many works through votes
  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_user.save
      new_work1 = Work.create(
        category: "album",
        title: "June Bug",
        creator: "Test Person", 
        publication_year: 2020,
        description: "Squirrel spin bulldog bark leash dog bone"
      )
      new_work2 = Work.create(
        category: "movie",
        title: "Hello Love",
        creator: "Test Person", 
        publication_year: 2019,
        description: "Woke fanny pack subway tile, venmo thundercats YOLO shabby chic VHS 90's fashion axe."
      )

      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work1.id)
      vote_2 = Vote.create(user_id: new_user.id, work_id: new_work2.id)
      # Assert
      expect(new_user.votes.count).must_equal 2
      new_user.vote.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a user_name" do
      # Arrange
      new_user.user_name = nil
      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :user_name
      expect(new_user.errors.messages[:user_name]).must_equal ["can't be blank"]
    end

    it "user_name must be unique" do
      User.create(
        user_name: "Junito the Burrito"
      )

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :user_name
      expect(new_user.errors.messages[:user_name]).must_equal ["has already been taken"]
    end

  end
end
