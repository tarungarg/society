require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Society
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # config.serve_static_assets = true

    config.time_zone = 'Kolkata'
    config.active_record.default_timezone = :local

    config.quiet_assets = true

    # actioncable settings
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", {expires_in: 90.minutes}
    config.action_cable.url = '/cable'
    config.action_cable.allowed_request_origins = [/https:\/\/*.*/, /http:\/\/*.*/]
  end
end
