# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  summary          :string(255)
#  notes            :text
#  day              :integer
#  week             :integer
#  created_at       :datetime
#  updated_at       :datetime
#  distance         :string           default("0 m")
#  duration         :string           default("0 s")
#  occurs_on        :date
#  schedulable_id   :integer
#  schedulable_type :string
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    summary "Run 5 miles"
    notes "Go easy"

    week { (1..36).to_a.sample }
    day { Entry.day_names.sample }
  end
end
