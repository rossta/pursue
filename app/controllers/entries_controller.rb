class EntriesController < ApplicationController
  # scoped to training_plan, schedule

  respond_to :html

  def index
    @entries = scope
    @title = @entry_context.title
    if index_params.any?
      @entries = @entries.where(index_params)
      @week    = @entry_context.week_number(index_params[:week])
      @title   += ": #{@week.title}"
    end
    @entries = @entries.order(week: :asc, day: :asc)
  end

  def show
    @entry = scope.find(params[:id])
  end

  def new
    @entry = scope.build
  end

  def create
    @entry = scope.create(entry_params)

    respond_with [@training_plan, @entry]
  end

  private

  def scope
    @entry_context = entry_context
    @entry_context.entries
  end

  def entry_context
    case
    when params[:training_plan_id]
      @training_plan = TrainingPlan.find(params[:training_plan_id])
    when params[:schedule_id]
      @schedule = Schedule.find(params[:schedule_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def entry_params
    params.require(:entry).permit(
      :summary,
      :notes,
      :week,
      :day,
      :discipline_name,
      :distance_unit,
      :duration_unit
    )
  end

  def index_params
    params.permit(:week, :day).slice(:week, :day)
  end

end
