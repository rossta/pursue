class Tagging::Discipline < Tagging
  default_scope { where(context: 'discipline') }
end

