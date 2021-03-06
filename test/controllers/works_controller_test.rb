require "test_helper"

#edit, update, destroy
describe WorksController do
  before do 
    @test_work = Work.create({
      category: "album",
      title: "June Bug",
      creator: "Test Person", 
      publication_year: 2020,
      description: "Squirrel spin bulldog bark leash dog bone, take it maltese milk bone leap dachshund dog bone tug leash. Pomeranian dog house tennis ball yorkshire terrier bring it pomeranian, dog house shih tzu squirrel bulldog. Rottweiler chase tail pit bull husky spin down speak. Poodle growl rottweiler fetch, great dance puppy stay leash come release rottweiler pit bull. Leash release chow chow growl maltese come chase tail rottweiler paw. Roll over jump dog toy sit shih tzu husky, spin bulldog pit bull dachshund heel doberman pinscher vet bring it. Sit pretty peanut butter jump bulldog, roll over dog come bite english mastiff squirrel bark bell. Milk bone poodle poodle fetch spin down, dog toy bulldog spin leash bring it. Yorkshire terrier spin puppies leap great dance squirrel german shephard."
    })

    @work_id = Work.find_by(title: "June Bug").id
  end

  describe "index" do
    it "responds with success" do
      # Arrange
      # Work.create({
      #   category: "album",
      #   title: "June Bug",
      #   creator: "Test Person", 
      #   publication_year: 2020,
      #   description: "Squirrel spin bulldog bark leash dog bone, take it maltese milk bone leap dachshund dog bone tug leash. Pomeranian dog house tennis ball yorkshire terrier bring it pomeranian, dog house shih tzu squirrel bulldog. Rottweiler chase tail pit bull husky spin down speak. Poodle growl rottweiler fetch, great dance puppy stay leash come release rottweiler pit bull. Leash release chow chow growl maltese come chase tail rottweiler paw. Roll over jump dog toy sit shih tzu husky, spin bulldog pit bull dachshund heel doberman pinscher vet bring it. Sit pretty peanut butter jump bulldog, roll over dog come bite english mastiff squirrel bark bell. Milk bone poodle poodle fetch spin down, dog toy bulldog spin leash bring it. Yorkshire terrier spin puppies leap great dance squirrel german shephard."
      # })
      
      # Act
      get "/works"
      # Assert
      must_respond_with :success
    end 

    it "responds with success when there are no works saved" do
      # Arrange
      # Ensure that there are zero works saved
      Work.all.each do |work|
        work.destroy
      end
      # Act
      get "/works"
      # Assert
      must_respond_with :success
    end
  end 

  describe "show" do
    it "responds with success when showing an existing valid work" do
      # Arrange
      # Before block
      # Act
      get "/works/#{@test_work.id}"
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid work id" do
      # Arrange
      # Ensure that there is an id that points to no work
      invalid_id = -1

      # Act
      get "/works/#{invalid_id}"

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      Work.new({
        category: "book",
        title: "Napping in Blankets",
        creator: "Junito the Burrito", 
        publication_year: 1994,
        description: "Squirrel spin bulldog bark leash dog bone,"
      })

      get "/works/new"

      must_respond_with :success

    end
  end

  describe "create" do
    it "can create a new work with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      work_hash = {
        work: {
          category: "album",
          title: "Chasing Squirrels",
          creator: "Junito the Burrito", 
          publication_year: 2019,
          description: "Lap dog bulldog boxer stay, dog bowl roll over lap dog come maltese roll over maltese jump tail."
        }
      }
        # Act-Assert
        # Ensure that there is a change of 1 in Work.count
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1
        # Assert
        # Find the newly created Work, and check that all its attributes match what was given in the form data
        # Check that the controller redirected the user
      work = Work.find_by(title: "Chasing Squirrels")
      must_redirect_to work_path(work.id)
      
      expect(work.category).must_equal work_hash[:work][:category]
      expect(work.title).must_equal work_hash[:work][:title]
      expect(work.creator).must_equal work_hash[:work][:creator]
      expect(work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(work.description).must_equal work_hash[:work][:description]
    end

    it "does not create a work if the form data violates work validations, and responds with bad_request" do
      # Arrange
      work_hash = {
        work: {
          category: "album",
          title: "Chasing Squirrels",
          creator: "Junito the Burrito", 
          publication_year: 2019,
          description: "Lap dog bulldog boxer stay, dog bowl roll over lap dog come maltese roll over maltese jump tail."
        }
      }
      # Set up the form data so that it violates Driver validations
      work_hash[:work][:title] = nil
      # Act-Assert
      # Ensure that there is no change in Work.count
      expect {
        post works_path, params: work_hash
      }.must_differ "Work.count", 0
      # Assert
      # Check that the controller renders bad_request
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      # Arrange
      # Before block 
      # Act
      get "/works/#{@work_id}/edit"
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      # Arrange
      # Ensure there is an invalid id that points to no work
      invalid_id = -1
      # Act
      get "/works/#{invalid_id}/edit"
      # Assert
      must_respond_with :not_found
    end
  end
  

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      #Arrange is before block & :
      work_hash = {
        work: {
          category: "album",
          title: "Chasing Squirrels",
          creator: "Junito the Burrito", 
          publication_year: 2019,
          description: "Lap dog bulldog boxer stay, dog bowl roll over lap dog come maltese roll over maltese jump tail."
        }
      }
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch work_path(@work_id), params: work_hash
      }.wont_change "Work.count"

      # Assert
      # Use the local variable of an existing works's id to find the work again, and check that its attributes are updated
      work = Work.find_by(id: @work_id)
      expect(work.category).must_equal work_hash[:work][:category]
      expect(work.title).must_equal work_hash[:work][:title]
      expect(work.creator).must_equal work_hash[:work][:creator]
      expect(work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(work.description).must_equal work_hash[:work][:description]

      # Check that the controller redirected the user
      must_redirect_to work_path(@work_id)
    end

    it "does not update any work if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no work
      invalid_id = -1
      # Set up the form data
      work_hash = {
        work: {
          category: "album",
          title: "Chasing Squirrels",
          creator: "Junito the Burrito", 
          publication_year: 2019,
          description: "Lap dog bulldog boxer stay, dog bowl roll over lap dog come maltese roll over maltese jump tail."
        }
      }

      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        patch work_path(invalid_id), params: work_hash
      }.wont_change "Work.count"
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a work if the form data violates Work validations, and responds with a redirect" do
      # Arrange
      # Before 
      # Set up the form data so that it violates Work's validations

      work_hash = {
        work: {
          category: "album",
          title: "Chasing Squirrels",
          creator: "Junito the Burrito", 
          publication_year: 2019,
          description: "Lap dog bulldog boxer stay, dog bowl roll over lap dog come maltese roll over maltese jump tail."
        }
      }

      work_hash[:work][:title] = nil
      # Act-Assert
      # Ensure that there is no change in Work.count
      expect {
        patch work_path(@work_id), params: work_hash
      }.wont_change "Work.count"

      # Assert
      # Check that the controller redirects
      must_respond_with :bad_request
    end
  end


  describe "destroy" do
    it "destroys the work instance in db when work exists, then redirects" do
      # Arrange
      # Before block
      # Act-Assert
      # Ensure that there is a change of -1 in Work.count
      expect {
        delete work_path(@work_id)
      }.must_differ "Work.count", -1

      # Assert
      # Check that the controller redirects
      must_redirect_to works_path
    end

    it "does not change the db when the work does not exist, then responds with not_found" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete work_path(invalid_id)
      }.wont_change "Work.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found

    end

  end
  
end
