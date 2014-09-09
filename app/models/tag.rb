# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  def to_s
    name
  end
end
