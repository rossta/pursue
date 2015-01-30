# == Schema Information
#
# Table name: training_plans
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  summary     :string(255)
#  creator_id  :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  total_weeks :integer
#  peak_week   :integer
#

class TrainingPlan < ActiveRecord::Base
  include Concerns::Categorizable

  has_one_category :distance

  belongs_to :creator, class_name: 'User'

  has_many :entries, as: :schedulable, dependent: :destroy

  attachment :thumbnail

  def total_weeks
    read_attribute(:total_weeks) || 27
  end

  def peak_week
    read_attribute(:peak_week) || total_weeks
  end

  def duration
    1..total_weeks
  end

  def weeks
    weeks_following(nil)
  end

  def weeks_following(start_date)
    TrainingWeek.following(start_date, total_weeks) do |w, i|
      number = i + 1
      w.number = number
      w.period = periodization.period(number)
    end
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  def period(week_number)
    periodization.period(week_number)
  end

  def starts_on(peaks_on)
    peaks_on + 1.day - peak_week.weeks
  end

  def ends_on(peaks_on)
    peaks_on + (total_weeks - peak_week).weeks
  end

  def exists?
    persisted?
  end

  def periodization
    @periodization ||= Periodization::Friel.new(peak_week: peak_week)
  end

end
