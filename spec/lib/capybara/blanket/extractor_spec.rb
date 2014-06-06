require 'spec_helper'

describe Capybara::Blanket::Extractor do

  let(:page) { FakePage.new }

  describe "#extract" do

    let(:extracted_data) { Capybara::Blanket::Extractor.extract page}

    it "should return data from page" do
      expect( extracted_data ).to eq page.coverage_data
    end
  end
end
