start_id = 1

yaml = YAML.load_file(Rails.root.join 'db/fixtures/entries/half_ironman/prep_train.yml')
yaml.each_with_index do |attrs, i|
  1.upto(3).each do |week|
    start_id += 1
    seeds = attrs.merge(id: start_id, week: week, training_plan_id: 5).reject { |k,v| v.blank? }
    Entry.seed(:id, seeds)
  end
end
yaml = YAML.load_file(Rails.root.join 'db/fixtures/entries/half_ironman/prep_rest.yml')
week = 4
yaml.each_with_index do |attrs, i|
  start_id += 1
  seeds = attrs.merge(id: start_id, week: week, training_plan_id: 5).reject { |k,v| v.blank? }
  Entry.seed(:id, seeds)
end
