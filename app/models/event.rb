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

class Event < ActiveRecord::Base
end
