class WorkoutPlansController < ApplicationController
  # scoped to training

  respond_to :html

  before_action :find_training_plan

  def index
    @workout_plans = scope
    @title = @training_plan.title
    if index_params.any?
      @workout_plans = @workout_plans.where(index_params)
      @title += ": Week #{index_params[:week]}"
    end
  end

  def show
    @workout_plan = scope.find(params[:id])
  end

  def new
    @workout_plan = scope.build
  end

  def create
    @workout_plan = scope.create(workout_plan_params)

    respond_with [@training_plan, @workout_plan]
  end

  private

  def find_training_plan
    @training_plan = TrainingPlan.find(params[:training_plan_id])
  end

  def workout_plan_params
    params.require(:workout_plan).permit(:summary, :notes, :week, :day)
  end

  def index_params
    params.slice(:week, :day)
  end

  def scope
    @training_plan.workout_plans
  end
end
