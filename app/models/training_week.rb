class TrainingWeek < Week
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attribute :number, Integer
  attribute :title, String

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

  def title
    @title || "Week #{number}"
  end

end
