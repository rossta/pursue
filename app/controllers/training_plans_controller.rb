class TrainingPlansController < ApplicationController

  respond_to :html

  def new
    @training_plan = TrainingPlan.new
  end

  def create
    @training_plan = TrainingPlan.create(training_plan_params) do |tp|
      tp.creator = current_user
    end

    respond_with @training_plan
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
