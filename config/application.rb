require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Spagro
  class Application < Rails::Application
    config.assets.enabled = true
    config.assets.compress = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('app', 'assets', 'texts')
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif  *.svg *.eot *.woff *.ttf)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :es
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "#{html_tag}".html_safe
    }
  end
end
