require 'figgy'

AppConfig = Figgy.build do |config|
  config.root = Rails.root.join('etc')
  config.always_reload = Rails.env.development?

  config.define_overlay(:default, nil)
  config.define_overlay(:development, 'development') if Rails.env.test?
  config.define_overlay(:local, 'local')
end
