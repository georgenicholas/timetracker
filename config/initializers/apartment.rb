
require 'apartment/elevators/subdomain'

Apartment.configure do |config|
  config.excluded_models = ['Account']
  config.tenant_names = -> { Account.pluck(:subdomain) }
end

Rails.application.config.middleware.use 'Apartment::Elevators::Subdomain'
