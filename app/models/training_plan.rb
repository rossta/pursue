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

  has_one_category :discipline

  belongs_to :creator, class_name: 'User'

  has_many :entries

  def total_weeks
    read_attribute(:total_weeks) || 36
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
      w.number = i + 1
      w.title = periodized_week_title(w)
    end
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  def periodized_week_title(week)
    period = period_name(week.number) || "Prep"
    "#{period}: #{week.title}"
  end

  def period_name(week_number)
    remaining = peak_week - week_number
    case
    when remaining < 0  then "Transition"
    when remaining == 0 then "Race"
    when remaining < 3  then "Peak"
    when remaining < 11 then "Build"
    when remaining < 23 then "Base"
    else "Prep"
    end
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
end
