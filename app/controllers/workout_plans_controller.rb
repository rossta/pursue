class WorkoutPlansController < ApplicationController
  # scoped to training_plan, schedule

  respond_to :html

  def index
    @workout_plans = scope
    @title = @workout_plan_context.title
    if index_params.any?
      @workout_plans = @workout_plans.where(index_params)
      @title += ": Week #{index_params[:week]}"
    end
    @workout_plans = @workout_plans.order(week: :asc, day: :asc)
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

  def scope
    @workout_plan_context = workout_plan_context
    @workout_plan_context.workout_plans
  end

  def workout_plan_context
    case
    when params[:training_plan_id]
      @training_plan = TrainingPlan.find(params[:training_plan_id])
    when params[:schedule_id]
      @schedule = Schedule.find(params[:schedule_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def workout_plan_params
    params.require(:workout_plan).permit(:summary, :notes, :week, :day, :discipline_name)
  end

  def index_params
    params.slice(:week, :day)
  end

end
