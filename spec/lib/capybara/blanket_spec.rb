require 'spec_helper'

describe Capybara::Blanket do

  let(:page) { FakePage.new }
  before(:each) do
    subject.start
    subject.extract_from(page)
  end

  describe "#files" do
    it "is a shortcut for coverage_data#files" do
      expect( subject.files ).to eq subject.coverage_data.files
    end
  end

  describe "#sources" do
    it "is a shortcut for coverage_data#sources" do
      expect( subject.sources ).to eq subject.coverage_data.sources
    end
  end

  describe "#extract_from" do
    context "Selenium-returned blanket.js coverage data structure characteristics" do
      let(:cov) do
        subject.coverage_data
      end
      specify { expect( cov['files'] ).to be}
      it "shows lines of coverage for each javascript file" do
        cov['files'].each do |filename,linedata|
          expect( filename ).to match(/.js$/)
          linedata.each_with_index do |cov_stats,line_number|
            expect( line_number ).to be_a Integer
            expect( cov_stats || 0 ).to be_a Integer # can be nil
          end
        end
      end
    end
  end

  describe "#percent" do
    it "returns total percent coverage of known lines of code as float" do
      expect( subject.coverage ).to eq 75.0
    end
    context "no data harvested yet" do
      it "returns zero" do
        subject.reset!
        expect( subject.coverage ).to eq 0.0
      end
    end
  end

  describe "#write_html_report" do
    let(:path) { '/tmp/capybara-blanket-report.html' }
    before { FileUtils.rm(path) if File.exists?(path) }

    it "generates an HTML file at the desired location" do
      subject.write_html_report path
      expect( File.exists? path ).to be_truthy
      system("open #{path}") if ENV['showreport']
    end
  end
end
