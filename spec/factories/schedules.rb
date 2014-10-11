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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    title "Training for a Half-Ironman"

    training_plan nil
    event nil
    owner nil

    starts_on { 1.month.from_now.beginning_of_week }
    peaks_on { |s| s.starts_on - 1.day + 8.weeks }
    ends_on { |s| s.peaks_on + 2.weeks }

  end
end
