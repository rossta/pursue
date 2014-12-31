require 'rails_helper'

describe Concerns::Categorizable do
  describe "self.normalize_category_name" do
    subject do
      Class.new do
        include Concerns::Categorizable
      end
    end

    # downcase
    it { expect(subject.normalize_category_name("RubyonRails")).to eq("rubyonrails") }

    # dasherize
    it { expect(subject.normalize_category_name("Ruby on Rails")).to eq("ruby-on-rails") }
    it { expect(subject.normalize_category_name("-Ruby on Rails-")).to eq("ruby-on-rails") }
    it { expect(subject.normalize_category_name("Ruby--on--Rails")).to eq("ruby-on-rails") }

    # transliteration (converts non-ASCII to ASCII)
    it { expect(subject.normalize_category_name("Ærøskøbing")).to eq("aeroskobing") }

    # Remove non-alphanumeric leading characters
    it { expect(subject.normalize_category_name("#rubyonrails")).to eq("rubyonrails") }
    it { expect(subject.normalize_category_name("???ruby-on-rails")).to eq("ruby-on-rails") }

    # special cases
    it { expect(subject.normalize_category_name("C++")).to eq("c++") }
    it { expect(subject.normalize_category_name("C#")).to eq("c#") }
    it { expect(subject.normalize_category_name("Node.js")).to eq("node.js") }
    it { expect(subject.normalize_category_name(".Net")).to eq(".net") }
    it { expect(subject.normalize_category_name("..Net")).to eq(".net") }

    # it "normalizes when setting name attribute" do
    #   tag.name = "Main TAG--Renamed "
    #   expect(tag.name).to eq("main-tag-renamed")
    #
    #   tag.attributes = { name: "Another Tag Name" }
    #   expect(tag.name).to eq("another-tag-name")
    # end
  end
end
