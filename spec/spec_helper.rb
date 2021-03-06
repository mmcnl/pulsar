require "rspec"
require "stringio"
require "fileutils"
require "coveralls"
require "pulsar"
require "pulsar/commands/main"
require "pulsar/commands/utils"

#
# Code coverage
#
Coveralls.wear!

#
# Require all helper modules
# 
Dir[File.join(File.dirname(__FILE__), 'support/modules/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Helpers
  config.include OutputCapture

  config.before(:each) do
    Dir.stub(:home).and_return("/fake/home")
    
    ENV.delete("PULSAR_APP_NAME")
    ENV.delete("PULSAR_CONF_REPO")
  end

  config.after(:each) do
    FileUtils.rm_rf(Dir.glob("#{File.dirname(__FILE__)}/support/tmp/*"))
  end
end
