class TrainingWeek < Week
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def self.model_name
    ActiveModel::Name.new(Week)
  end

  def id
    number
  end

  def persisted?
    false
  end

  def to_param
    number.to_s
  end

end
