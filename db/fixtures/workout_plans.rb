# training_plan_id 5
weeks = [
  ['3 m run', '5 m run', '3 m run', '3 x hill', 'Rest', '5 m pace', '10 m LSD'],
  ['3 m run', '5 m run', '3 m run', '30 tempo', 'Rest', '5 m run',  '11 m LSD'],
  ['3 m run', '6 m run', '3 m run', '4 x 800',  'Rest', '6 m pace', '8 m LSD'],
  ['3 m run', '6 m run', '3 m run', '4 x hill', 'Rest', '6 m pace', '13 m LSD'],
  ['3 m run', '7 m run', '3 m run', '35 tempo', 'Rest', '7 m run',  '14 m LSD'],
  ['3 m run', '7 m run', '3 m run', '5 x 800',  'Rest', '7 m pace', '10 m LSD'],
  ['3 m run', '8 m run', '4 m run', '5 x hill', 'Rest', '8 m pace', '16 m LSD'],
  ['3 m run', '8 m run', '4 m run', '40 tempo', 'Rest', '8 m run',  '17 m LSD'],
  ['3 m run', '9 m run', '4 m run', '6 x 800',  'Rest', 'Rest', 'Half Marathon'],
  ['3 m run', '9 m run',  '4 m run', '6 x hill', 'Rest', '9 m pace','19 m LSD'],
  ['4 m run', '10 m run', '5 m run', '45 tempo', 'Rest', '10 m run','20 m LSD'],
  ['4 m run', '6 m run',  '5 m run', '7 x 800 ', 'Rest', '6 m pace','12 m LSD'],
  ['4 m run', '10 m run', '5 m run', '7 x hill', 'Rest', '10 m pace', '20 m LSD'],
  ['5 m run', '6 m run',  '5 m run', '45 tempo', 'Rest', '6 m run', '12 m LSD'],
  ['5 m run', '10 m run', '5 m run', '8 x 800 ', 'Rest', '10 m pace', '20 m LSD'],
  ['5 m run', '8 m run',  '5 m run', '6 x hill', 'Rest', '4 m pace', '12 m LSD'],
  ['4 m run', '6 m run',  '4 m run', '30 tempo', 'Rest', '4 m run', '8 m LSD'],
  ['3 m run', '4 x 400',  '2 m run', 'Rest',     'Rest', '2 m run', 'Marathon'],
]
id = 0
weeks.each_with_index do |week, i|
  week_num = i+1
  week.each_with_index do |day, j|
    id  = id+1
    summary = week[j]
    discipline_name = summary =~ /rest/i ? 'rest' : 'run'
    WorkoutPlan.seed(:id, {
      id: id,
      week: week_num,
      day: WorkoutPlan.day_names[j],
      summary: summary,
      training_plan_id: 5,
      discipline_name: discipline_name
    })
  end
end
