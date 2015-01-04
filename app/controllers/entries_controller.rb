class EntriesController < ApplicationController
  # scoped to training_plan, schedule

  respond_to :html

  def index
    @entries = scope
    @title = @entry_scope.title
    if index_params.any?
      @entries = @entries.where(index_params)
      @week    = @entry_scope.week_number(index_params[:week])
      @title   += ": #{@week.title}"
    end
    @entries = @entries.order(week: :asc, day: :asc)
  end

  def show
    @entry = scope.find(params[:id])
  end

  def new
    @entry = scope.build(index_params)
  end

  def create
    @entry = scope.build(entry_params)

    if @entry.save
      redirect_to [@training_plan, @entry], notice: "Success"
    else
      render :new
    end
  end

  def edit
    @entry = scope.find(params[:id])
  end

  def update
    @entry = scope.find(params[:id])
    @entry.attributes = entry_params

    if @entry.save
      redirect_to [@training_plan, @entry], notice: "Success"
    else
      render :edit
    end
  end

  private

  def scope
    @entry_scope = entry_scope
    @entry_scope.entries
  end

  def entry_scope
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
      :zone_name,
      :period_name,
      :distance,
      :duration,
      ability_names: [],
      strength_ability_names: []
    )
  end

  def index_params
    params.permit(:schedule_id, :training_plan_id, :week, :day).slice(:week, :day)
  end
  helper_method :index_params

end
