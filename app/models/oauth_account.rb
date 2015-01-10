class OauthAccount < ActiveRecord::Base

  scope :strava, -> { where(provider: 'strava') }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |oa|
      oa.email      = auth.info.email
      oa.name       = auth.info.name
      oa.first_name = auth.info.first_name
      oa.last_name  = auth.info.last_name
      oa.location   = auth.info.location
      oa.token      = auth.credentials.token
    end
  end
end
