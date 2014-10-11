class NullTrainingPlan
  include Singleton

  def title
    "Wannabe Plan"
  end

  def weeks_following(*args)
    []
  end
end
