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

class Tagging::Discipline < Tagging
  default_scope { where(context: 'discipline') }

  def distance_unit
    case tag.name
    when "bike", "run"
      'mi'
    when "swim"
      'yards'
    end
  end
end
