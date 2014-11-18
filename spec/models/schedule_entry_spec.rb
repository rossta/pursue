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

require 'rails_helper'

RSpec.describe ScheduleEntry, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
