module Capybara
  module Blanket
    module Extractor
      class << self
        def extract page
          if page
            page
            sleep(0.2) until coverage_is_setup? page
            page.evaluate_script("blanket.onTestsDone();")
            sleep(0.2) until data_ready? page
            page_data = page.evaluate_script("window.CAPYBARA_BLANKET")
            return page_data
          end
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
