start_id = 0
periodization = Periodization::Friel.new

periodization.each do |week|
  basename = week.to_a # number, name, chunk, mode
  basename.shift
  basename = basename.map(&:downcase).join("_") # name_version_mode
  file = Rails.root.join "db/fixtures/entries/half_ironman/#{basename}.yml"

  if !File.exist?(file)
    warn "Skipping file not found: #{file}"
    next
  end

  YAML.load_file(file).each do |attrs|
    start_id += 1
    seeds = attrs.merge(

      id: start_id,
      week: week.number,
      schedulable_id: 1,
      schedulable_type: 'TrainingPlan'

    ).reject { |k,v| v.blank? }

    Entry.seed(:id, seeds)
  end
end
