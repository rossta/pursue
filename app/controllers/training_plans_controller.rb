class TrainingPlansController < ApplicationController

  respond_to :html

  def new
    @training_plan = TrainingPlan.new
  end

  def create
    @training_plan = TrainingPlan.new(training_plan_params) do |tp|
      tp.creator = current_user
    end

    if @training_plan.save
      redirect_to @training_plan, notice: "Success!"
    else
      render :new
    end
  end

  def show
    @training_plan = TrainingPlan.find(params[:id])
  end

  def index
    @training_plans = TrainingPlan.all
  end

  private

  def training_plan_params
    params.require(:training_plan).permit(:title, :summary)
  end
end
