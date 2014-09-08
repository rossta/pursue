class Tagging::EventDiscipline < Tagging
  default_scope { where(context: 'discipline') }
end
