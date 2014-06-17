module Capybara
  module Blanket
    module ReportWriter
      class << self
        def write_report path, report
          makepath path
          File.open(path, 'w') do |file|
            file.write(report)
          end
        end

        def makepath path
          dirname = File.dirname path
          FileUtils.mkdir_p dirname
        end
      end
    end
  end
end
