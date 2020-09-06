require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    config.encoding = "UTF-8"
    config.active_record.default_timezone = :utc
    config.time_zone = 'Beijing'
    config.action_cable.disable_request_forgery_protection = true
    config.i18n.fallbacks = true
    
   
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
