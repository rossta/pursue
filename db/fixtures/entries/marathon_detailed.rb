require 'plan_parser/training_peaks'

yaml = YAML.load_file('db/fixtures/plans/training_peaks_marathon_advanced.yml')

dates = yaml.values.map { |day| day.date rescue nil }.compact

weeks = Week.following(dates.first, dates.size)

yaml.each do |key, day|
  week = weeks.detect { |w| w.days.cover? day.date }
  raise "Week not found for #{key}" unless week

  week_num = weeks.index(week) + 1
  day_num  = week.days.to_a.index(day.date)

  day.activities.each do |activity|

    activity.posts.each do |post|
      Entry.seed(:week, :day, :training_plan_id, {
        week: week_num,
        day: day_num,
        summary: post.label,
        notes: post.notes,
        training_plan_id: 6,
        discipline_name: activity.tag
      })
    end
  end
end
