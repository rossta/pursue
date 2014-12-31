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
  include Concerns::Categorizable
  has_one_category :distance
end
