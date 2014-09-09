class SchedulesController < ApplicationController

  before_action :authenticate_user!

  respond_to :html

  def show
    @schedule = schedule_scope.find(params[:id])
  end

  def new
    @schedule = schedule_scope.build
  end

  def create
    @schedule = schedule_scope.create do |s|
      s.event = scheduled_event
      s.training_plan = scheduled_training_plan
    end

    respond_with @schedule
  end

  private

  def schedule_scope
    current_user.schedules
  end

  def schedule_params
    params.require(:schedule).permit(:event_id, :training_plan_id)
  end

  def scheduled_event
    Event.find(schedule_params[:event_id])
  end

  def scheduled_training_plan
    TrainingPlan.find(schedule_params[:training_plan_id])
  end
end
