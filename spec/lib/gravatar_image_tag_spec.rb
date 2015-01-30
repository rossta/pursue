require 'spec_helper'
require 'gravatar_image_tag'
require 'uri'
require 'digest'
require "action_view"

describe GravatarImageTag do

  email                 = 'mdeering@mdeering.com'
  md5                   = '4da9ad2bd4a2d1ce3c428e32c423588a'
  default_filetype      = :gif
  default_image         = 'http://mdeering.com/images/default_gravatar.png'
  default_image_escaped = 'http%3A%2F%2Fmdeering.com%2Fimages%2Fdefault_gravatar.png'
  default_rating        = 'x'
  default_size          = 50
  other_image           = 'http://mdeering.com/images/other_gravatar.png'
  other_image_escaped   = 'http%3A%2F%2Fmdeering.com%2Fimages%2Fother_gravatar.png'
  secure                = false

  helper_class = Class.new do
    include ActionView::Helpers
    include GravatarImageTag
  end

  before do
    GravatarImageTag.configure do |c|
      c.default_image = default_image
      c.filetype = default_filetype
      c.rating = default_rating
      c.secure = secure
      c.size = default_size
      c.include_size_attributes = true
    end
  end

  let(:view) { helper_class.new }

  context '#gravatar_image_tag' do

    {
      { gravatar_id: md5 } => {},
      { gravatar_id: md5 } => { gravatar: { rating: 'x' } },
      { gravatar_id: md5, size: 30 } => { gravatar: { size: 30 } },
      { gravatar_id: md5, default: other_image_escaped } => { gravatar: { default: other_image } },
      { gravatar_id: md5, default: other_image_escaped, size: 30 } => { gravatar: { default: other_image, size: 30 } }
    }.each do |params, options|
      it "#gravatar_image_tag should create the provided url with the provided options #{options}" do
        image_tag = view.gravatar_image_tag(email, options)
        expect(image_tag).to include("#{params.delete(:gravatar_id)}")
        params.each {|key, value| expect(image_tag).to include("#{key}=#{value}")}
      end
    end

    # Now that the defaults are set...
    {
      { gravatar_id: md5, size: default_size, default: default_image_escaped } => {},
      { gravatar_id: md5, size: 30, default: default_image_escaped } => { gravatar: { size: 30 } },
      { gravatar_id: md5, size: default_size, default: other_image_escaped } => { gravatar: { default: other_image } },
      { gravatar_id: md5, size: 30, default: other_image_escaped } => { gravatar: { default: other_image, size: 30 } },
    }.each do |params, options|
      it "#gravatar_image_tag #{params} should create the provided url when defaults have been set with the provided options #{options}" do
        image_tag = view.gravatar_image_tag(email, options)
        expect(image_tag).to include("#{params.delete(:gravatar_id)}.#{default_filetype}")
        params.each {|key, value| expect(image_tag).to include("#{key}=#{value}")}
      end
    end

    it 'should request the gravatar image from the non-secure server when the https: false option is given' do
      expect(view.gravatar_image_tag(email, { gravatar: { secure: false } })).to match(/src="http:\/\/gravatar.com\/avatar\//)
    end

    it 'should request the gravatar image from the secure server when the https: true option is given' do
      expect(view.gravatar_image_tag(email, { gravatar: { secure: true } })).to match(/src="https:\/\/secure.gravatar.com\/avatar\//)
    end

    it 'should set the image tags height and width to avoid the page going all jiggy (technical term) when loading a page with lots of Gravatars' do
      GravatarImageTag.configure { |c| c.size = 30 }
      expect(view.gravatar_image_tag(email)).to match(/height="30"/)
      expect(view.gravatar_image_tag(email)).to match(/width="30"/)
    end

    it 'should set the image tags height and width attributes to 80px (gravatars default) if no size is given.' do
      GravatarImageTag.configure { |c| c.size = nil }
      expect(view.gravatar_image_tag(email)).to match(/height="80"/)
      expect(view.gravatar_image_tag(email)).to match(/width="80"/)
    end

    it 'should set the image tags height and width attributes from the overrides on the size' do
      GravatarImageTag.configure { |c| c.size = 120 }
      expect(view.gravatar_image_tag(email, gravatar: { size: 45 })).to match(/height="45"/)
      expect(view.gravatar_image_tag(email, gravatar: { size: 75 })).to match(/width="75"/)
    end

    it 'should not include the height and width attributes on the image tag if it is turned off in the configuration' do
      GravatarImageTag.configure { |c| c.include_size_attributes = false }
      expect(view.gravatar_image_tag(email)).to_not match(/height=/)
      expect(view.gravatar_image_tag(email)).to_not match(/width=/)
    end

    it 'GravatarImageTag#gravitar_id should not error out when email is nil' do
      expect { GravatarImageTag::gravatar_id(nil) }.to_not raise_error
    end

    it 'should normalize the email to Gravatar standards (http://en.gravatar.com/site/implement/hash/)' do
      expect(view.gravatar_image_tag(" camelCaseEmail@example.com\t\n")).to eq view.gravatar_image_tag('camelcaseemail@example.com')
    end

  end

  context '#gravatar_image_url' do

    it '#gravatar_image_url should return a gravatar URL' do
      expect(view.gravatar_image_url(email)).to match(/^http:\/\/gravatar.com\/avatar\//)
    end

    it '#gravatar_image_url should set the email as an md5 digest' do
      expect(view.gravatar_image_url(email)).to match("http:\/\/gravatar.com\/avatar\/#{md5}")
    end

    it '#gravatar_image_url should set the default_image' do
      expect(view.gravatar_image_url(email)).to include("default=#{default_image_escaped}")
    end

    it '#gravatar_image_url should set the filetype' do
      expect(view.gravatar_image_url(email, filetype: :png)).to match("http:\/\/gravatar.com\/avatar\/#{md5}.png")
    end

    it '#gravatar_image_url should set the rating' do
      expect(view.gravatar_image_url(email, rating: 'pg')).to include("rating=pg")
    end

    it '#gravatar_image_url should set the size' do
      expect(view.gravatar_image_url(email, size: 100)).to match(/size=100/)
    end

    it '#gravatar_image_url should use http protocol when the https: false option is given' do
      expect(view.gravatar_image_url(email, secure: false)).to match("^http:\/\/gravatar.com\/avatar\/")
    end

    it '#gravatar_image_url should use https protocol when the https: true option is given' do
      expect(view.gravatar_image_url(email, secure: true)).to match("^https:\/\/secure.gravatar.com\/avatar\/")
    end

  end

end
