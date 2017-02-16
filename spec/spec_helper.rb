require "bundler/setup"
::Bundler.require(:default, :test)
require "shoulda/matchers"
::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end
RSpec.configure do |config|
end
