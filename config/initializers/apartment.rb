
require 'apartment/elevators/subdomain'

Apartment.configure do |config|



  config.excluded_models = ['Account']

end

Rails.application.config.middleware.use 'Apartment::Elevators::Subdomain'
