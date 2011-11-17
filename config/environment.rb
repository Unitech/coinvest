# Load the rails application
require File.expand_path('../application', __FILE__)

# Rails.logger = Logger.new(STDOUT)
# Rails.logger = Log4r::Logger.new("Application Log")

# Initialize the rails application
Coinvest::Application.initialize!
