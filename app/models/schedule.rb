# == Schema Information
#
# Table name: schedules
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  training_plan_id :integer
#  event_id         :integer
#  owner_id         :integer
#  peaks_on         :date
#  starts_on        :date
#  ends_on          :date
#  created_at       :datetime
#  updated_at       :datetime
#

class Schedule < ActiveRecord::Base
  belongs_to :training_plan
  belongs_to :event
  belongs_to :owner, class_name: 'User'

  before_create :set_title
  before_save :set_dates

  # def duration
  # def peak_week
  # def entries
  delegate :peak_week, :duration, :entries, to: :training_plan, allow_nil: true

  def weeks
    training_plan.weeks_following(starts_on)
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  private

  def set_title
    return if self.title
    return unless self.event_id_changed?

    self.title = "Training for #{event.title}"
  end

  def set_dates
    set_peaks_on
    set_starts_and_ends_on
  end

  def set_peaks_on
    return unless event_id_changed?

    self.peaks_on = event.occurs_on
  end

  def set_starts_and_ends_on
    return unless self.peaks_on && training_plan_id_changed?

    self.starts_on = training_plan.starts_on(self.peaks_on)
    self.ends_on = training_plan.ends_on(self.peaks_on)
  end

end
