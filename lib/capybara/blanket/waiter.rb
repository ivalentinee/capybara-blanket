module Capybara
  module Blanket
    class Waiter
      attr_reader :on_coverage_setup

      def initialize(page, on_coverage_setup = "")
        @page = page
        @on_coverage_setup = on_coverage_setup
      end

      def wait_for_page
        @start = Time.now

        wait_for_coverage_setup
        @page.evaluate_script(on_coverage_setup)
        wait_for_coverage_data
      end

      private

      def wait_for_coverage_setup
        until coverage_is_setup?
          raise TimeoutError.new("timeout while waiting for coverage setup") if timeout?
          sleep(0.2)
        end
      end

      def wait_for_coverage_data
        until data_ready?
          raise TimeoutError.new("timeout while waiting for coverage data") if timeout?
          sleep(0.2)
        end
      end

      def timeout?
        Time.now - @start > Capybara.default_wait_time
      end

      def coverage_is_setup?
        @page.evaluate_script("window.CAPYBARA_BLANKET.is_setup") rescue false
      end

      def data_ready?
        @page.evaluate_script("window.CAPYBARA_BLANKET.done") rescue false
      end
    end
  end
end
