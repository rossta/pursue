require 'plan_parser/training_peaks'

yaml = YAML.load_file('db/fixtures/plans/training_peaks_marathon_advanced.yml')

dates = yaml.values.map { |day| day.date rescue nil }.compact

weeks = Week.following(dates.first.beginning_of_week, dates.size)

id = 500
yaml.each do |key, day|
  week = weeks.detect { |w| w.days.cover? day.date }
  raise "Week not found for #{key}" unless week

  week_num = weeks.index(week) + 1
  day_name = day.day_of_week

  day.activities.each do |activity|
    tag = activity.tag.underscore
    activity.posts.each do |post|
      Entry.seed(:id, {
        id: id += 1,
        week: week_num,
        day: day_name,
        summary: post.label,
        notes: post.notes,
        training_plan_id: 6,
        discipline_name: tag
      })
    end
  end
end
