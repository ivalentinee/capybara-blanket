class MiniTest::Unit::TestCase
  MiniTest::Unit.after_tests do
    Capybara::Blanket.write_report
    puts Capybara::Blanket.coverage
  end
end
