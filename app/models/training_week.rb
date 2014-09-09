class TrainingWeek < Week

  def to_param
    number.to_s
  end
end
