class WorksController < ApplicationController
  def index
    @works = Work.all
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
    @work = Passenger.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
