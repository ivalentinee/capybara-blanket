class MiniTest::Unit::TestCase
  MiniTest::Unit.after_tests do
    puts Capybara::Blanket.coverage
    Capybara::Blanket.write_html_report File.join(File.dirname(__FILE__), '../javascript_coverage.html')
  end
end
