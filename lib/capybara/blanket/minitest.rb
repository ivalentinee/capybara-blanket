class MiniTest::Unit::TestCase
  MiniTest::Unit.after_tests do
    if Capybara::Blanket.test_started?
      Capybara::Blanket.write_report
      puts "Total javascript coverage: #{Capybara::Blanket.coverage}%"
    end
  end
end
