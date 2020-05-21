require "test_helper"

describe UsersController do
  it "can get login form" do 
    get login_path
    must_respond_with :success
  end

  describe "logging in" do 
    it "can login a new user" do 
      user = nil 

      expect{ 
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect 

      user = User.find_by(user_name: user.user_name)
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.user_name).must_equal user_hash[:user][:user_name]
    end 

    it "can login an existing user" do 
      user = User.create(user_name: "Buggito the Pumpkin")
      expect{
        login(user.user_name)
      }.wont_change "User.count"

      expect (session[:user_id]).must_equal user.id
    end 
  end 

  describe "logout" do 
    it "can loggout a logged in user" do 
      #arrange 
      login()
      expect(session[:user_id]).wont_be_nil 
      #act
      post logout_path 

      #assert 
      expect(session[:user_id]).must_be_nil 
    end 


  end 
end
