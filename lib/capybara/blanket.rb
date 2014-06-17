require "capybara/blanket/version"
require "capybara/blanket/rails"

module Capybara
  module Blanket
    autoload 'CoverageData', 'capybara/blanket/coverage_data'
    autoload 'Extractor', 'capybara/blanket/extractor'
    autoload 'Waiter', 'capybara/blanket/waiter'
    autoload 'ReportGenerator', 'capybara/blanket/report_generator'
    autoload 'ReportWriter', 'capybara/blanket/report_writer'

    class << self
      @@test_started = false

      def start
        @@coverage_data = CoverageData.new
        test_started!
      end

      def coverage_data
        @@coverage_data
      end

      def reset!
        @@coverage_data = CoverageData.new
      end

      def method_missing *args
        self.coverage_data.send(*args)
      end

      def extract_from page
        if test_started?
          page_data = Extractor.extract page
          coverage_data.accrue! page_data
          return page_data
        end
      end

      def coverage
        coverage_data.coverage
      end

      def test_started?
        @@test_started
      end

      def write_report
        generator = ReportGenerator.new(:html, self)
        ReportWriter.write_report 'coverage/js-coverage.html', generator.render
      end

      private

      def test_started!
        @@test_started = true
      end
    end
  end
end
