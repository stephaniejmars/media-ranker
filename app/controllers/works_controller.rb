class WorksController < ApplicationController
  
  def index
    @works = Work.all
    @album_collection = Work.where(category: "album")
    @movie_collection = Work.where(category: "movie")
    @book_collection = Work.where(category: "book")
  end

  def new 
    @work = Work.new
  end

  def create
    @work = Work.new work_params

    if @work.save
      redirect_to work_path(@work.id)
      flash[:success] = "Work Successfully Created"
    else
      flash.now[:error] = "Failed to Create Work"
      render :new, status: :bad_request
    end
  end 

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      flash[:success] = "Work Successfully Updated"
      return
    else 
      render :edit, status: :bad_request
      flash.now[:error] = "Failed to Update Work"
      return
    end
  end

  def destroy
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      head :not_found
      return
    end
    
    @work.destroy
    redirect_to works_path 
    flash[:success] = "Work Successfully Deleted"
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
