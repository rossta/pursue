# == Schema Information
#
# Table name: schedule_entries
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  entry_id    :integer
#  occurs_on   :date
#  created_at  :datetime
#  updated_at  :datetime
#

class ScheduleEntry < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :entry

  scope :today, -> { where(occurs_on: Date.today) }
  scope :tomorrow, -> { where(occurs_on: Date.tomorrow) }
end
