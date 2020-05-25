class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @spotlight = Work.spotlight
    @top_ten_movie = Work.top_ten("movie")
    @top_ten_album = Work.top_ten("album")
    @top_ten_book = Work.top_ten("book")
  end
end
