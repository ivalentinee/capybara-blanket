module Capybara
  module Blanket
    module Extractor
      class << self
        def extract page
          if page
            Waiter.wait_for page
            page_data = page.evaluate_script("window.CAPYBARA_BLANKET")
            return page_data
          end
        end
      end
    end
  end
end
