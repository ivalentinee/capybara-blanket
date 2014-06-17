require 'spec_helper'

describe Capybara::Blanket::ReportWriter do

  let(:page) { FakePage.new }
  before(:each) do
    Capybara::Blanket.start
    Capybara::Blanket.extract_from(page)
  end

  describe "#write_report" do
    let(:path) { '/tmp/capybara-blanket/capybara-blanket-report.html' }
    before { FileUtils.rm(path) if File.exists?(path) }

    it "writes file at the desired location" do
      subject.write_report path, ""
      expect( File.exists? path ).to be_truthy
      system("open #{path}") if ENV['showreport']
    end
  end
end
