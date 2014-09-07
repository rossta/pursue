class WorkoutPlansController < ApplicationController
  # scoped to training

  respond_to :html

  before_action :find_training_plan

  def new
    @workout_plan = @training_plan.workout_plans.build
  end

  def create
    @workout_plan = @training_plan.workout_plans.create(workout_plan_params)

    respond_with [@training_plan, @workout_plan]
  end

  def show
    @workout_plan = @training_plan.workout_plans.find(params[:id])
  end

  private

  def find_training_plan
    @training_plan = TrainingPlan.find(params[:training_plan_id])
  end

  def workout_plan_params
    params.require(:workout_plan).permit(:summary, :notes, :week, :day)
  end
end
