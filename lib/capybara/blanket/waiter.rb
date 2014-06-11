module Capybara
  module Blanket
    module Waiter
      class << self
        def wait_for page
          sleep(0.2) until coverage_is_setup? page
          page.evaluate_script("blanket.onTestsDone();")
          sleep(0.2) until data_ready? page
        end

        def coverage_is_setup? page
          page.evaluate_script("window.CAPYBARA_BLANKET.is_setup") rescue false
        end

        def data_ready? page
          page.evaluate_script("window.CAPYBARA_BLANKET.done") rescue false
        end
      end
    end
  end
end
