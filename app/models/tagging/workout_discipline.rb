class Tagging::WorkoutDiscipline < Tagging
  default_scope { where(context: 'discipline') }
end
