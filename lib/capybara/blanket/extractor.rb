module Capybara
  module Blanket
    module Extractor
      class << self
        def extract page
          if page
            waiter = Waiter.new(page, "blanket.onTestsDone();")
            waiter.wait_for_page
            page_data = page.evaluate_script("window.CAPYBARA_BLANKET")
            return page_data
          end
        end
      end
    end
  end
end
