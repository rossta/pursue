# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  occurs_on  :date
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "Ironman 70.3 Mont-Tremblant"

    trait :upcoming do
      occurs_on 9.months.from_now
    end
  end
end
