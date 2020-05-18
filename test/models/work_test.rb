require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(
      category: "album",
      title: "June Bug",
      creator: "Test Person", 
      publication_year: 2020,
      description: "Squirrel spin bulldog bark leash dog bone"
    )
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      # Assert
      expect(work).must_respond_to field
    end
  end

  # validates :category, presence: true
  # validates :title, presence: true, uniqueness: true
  # validates :creator, presence: true
  # validates :publication_year, presence: true

  describe "validations" do
    it "must have a category" do
      # Arrange
      new_work.category = nil
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      # Arrange
      new_work.title = nil
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "title must be unique" do
      Work.create(
        category: "album",
        title: "June Bug",
        creator: "Test Person", 
        publication_year: 2020,
        description: "Squirrel spin bulldog bark leash dog bone"
      )

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "must have a creator" do
      # Arrange
      new_work.creator = nil
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication_year" do
      # Arrange
      new_work.publication_year = nil
      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end
    
  end
end
