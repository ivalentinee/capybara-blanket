require 'capybara/blanket'

module Capybara
  module Blanket
    module Rails
      if defined? ::Rails::Engine
        class Engine < ::Rails::Engine
        end
      end
    end
  end
end
