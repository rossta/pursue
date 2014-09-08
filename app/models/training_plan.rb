class TrainingPlan < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  has_many :workout_plans

  has_one :discipline_tagging, as: :taggable, dependent: :destroy, class_name: "Tagging::EventDiscipline"
  has_one :discipline, through: :discipline_tagging, source: :tag, class_name: "Tag"

  def max_week
    24
  end

  def weeks
    1..24
  end

  # def discipline_name
  delegate :name, to: :discipline, allow_nil: true, prefix: true

  def discipline_name=(name)
    self.discipline = Tag.find_or_create_by(name: name)
  end

end
