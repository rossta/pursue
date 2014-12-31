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

  def self.seed_fixtures(context = :fixtures)
    self.const_get(context.to_s.upcase).each do |name|
      find_or_create_by(name: normalize_category_name(name))
    end
  end

  def self.normalize_category_name(name)
    sep = '-'
    normalized = ActiveSupport::Inflector.transliterate(name)
    normalized = normalized.strip.downcase.underscore.dasherize
    normalized = normalized.gsub(%r{\s+}, sep)
    normalized = normalized.gsub(%r{^[^\w|\.]*|-$}, '')   # normalize start/end chars
    normalized = normalized.gsub(%r{#{sep}{2,}}, sep)     # remove repeated -
    normalized = normalized.gsub(%r{\.{2,}}, '.')         # remove repeated .
  end

  def to_s
    name
  end

  SPORTS = %w[ triathlon running ]

  DISTANCES = %w[ ironman half-ironman olympic sprint marathon half-marathon ]

  DISCIPLINES = %w[ swim bike run rest strength ]

  PERIODS = %w[ prep base build peak race transition ]

  ZONES = %w[ zone-1 zone-2 zone-3 zone-4 zone-5 ]

  ABILITIES = %w[
  aerobic-endurance
    speed-skills
    force
    muscular-endurance
    anaerobic-endurance
    power
  ]

  STRENGTH_ABILITIES = %w[
  anatomical-adaptation
    maximum-transition
    maximum-strength
    strength-maintenance
  ]

  FIXTURES = SPORTS + DISTANCES + DISCIPLINES + PERIODS + ZONES + ABILITIES + STRENGTH_ABILITIES

end
