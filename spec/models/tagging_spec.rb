# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  tag_type      :string(255)
#  taggable_id   :integer
#  taggable_type :string(255)
#  tagger_id     :integer
#  tagger_type   :string(255)
#  context       :string(128)
#  created_at    :datetime
#

require 'rails_helper'

RSpec.describe Tagging, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
