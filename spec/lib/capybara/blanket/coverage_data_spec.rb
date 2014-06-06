require 'spec_helper'

describe Capybara::Blanket::CoverageData do
  before(:each) { Capybara::Blanket.reset! }
  let(:page) { FakePage.new }
  let(:covdata) do
    Capybara::Blanket.extract_from(page)
    Capybara::Blanket.coverage_data
  end

  describe "#accrue!" do
    let(:new_page_data) do
      page_data = Marshal.load(Marshal.dump(covdata.data))
      page_data['files'].first[1][0] = 3 # add coverage on that line
      page_data
    end
    it "squishes coverage datasets together" do
      expect( covdata["files"].first[1][0] ).to be_nil
      expect( covdata["files"].first[1][1] ).to eq 1
      covdata.accrue! new_page_data
      expect( covdata["files"].first[1][0] ).to eq 3
      expect( covdata["files"].first[1][1] ).to eq 2
    end

    context "filename exists but is not iterable" do
      let(:new_page_data) do
        Marshal.load(Marshal.dump(covdata.data))
      end
      before do
        @data_copy = new_page_data
        @filename = covdata['files'].first[0]
        covdata['files'][@filename] = nil
      end
      it "will not try to iterate over nil" do
        expect {covdata.accrue! @data_copy}.not_to raise_error
      end
    end
  end


  describe "#files" do
    it "shorthand for accessing the files hash" do
      expect( covdata.files ).to eq covdata.data['files']
      expect( covdata.files ).to be_a Hash
    end
    it "has a shortcut that produces the same data" do
      expect( Capybara::Blanket.files ).to eq covdata.files
    end
  end

  describe "#sources" do
    it "shorthand for accessing the sources hash" do
      expect( covdata.sources ).to eq covdata.data['sources']
      expect( covdata.sources ).to be_a Hash
    end
    it "has a shortcut that produces the same data" do
      expect( Capybara::Blanket.sources ).to eq covdata.sources
    end
  end

  describe "#percent_covered" do
    it "returns the percent covered for a given script" do
      res = covdata.percent_covered covdata.files.keys[1]
      expect( res ).to eq 60.0
    end
  end
end
