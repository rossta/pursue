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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_entry do
    schedule nil
    entry nil
    occurs_on "2014-10-12"
  end
end
