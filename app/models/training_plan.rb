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
  belongs_to :creator, class_name: 'User'

  has_many :entries

  has_one :discipline_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::EventDiscipline"
  has_one :discipline, through: :discipline_tagging, source: :tag, class_name: "Tag"

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
    end
  end

  def week_number(number)
    weeks[number.to_i-1]
  end

  # def discipline_name
  delegate :name, to: :discipline, allow_nil: true, prefix: true

  def discipline_name=(name)
    self.discipline = Tag.find_or_create_by(name: name)
  end

  def starts_on(peaks_on)
    peaks_on + 1.day - peak_week.weeks
  end

  def ends_on(peaks_on)
    peaks_on + (total_weeks - peak_week).weeks
  end
end
