class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @album_collection = Work.where(category: "album")
    @movie_collection = Work.where(category: "movie")
    @book_collection = Work.where(category: "book")
  end
end
