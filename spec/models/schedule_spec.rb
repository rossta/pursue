# == Schema Information
#
# Table name: schedules
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  training_plan_id :integer
#  event_id         :integer
#  owner_id         :integer
#  peaks_on         :date
#  starts_on        :date
#  ends_on          :date
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe Schedule, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
