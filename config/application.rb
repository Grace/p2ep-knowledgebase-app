require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require 'neo4j/railtie'
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module P2epKnowledgebase
  class Application < Rails::Application
    
    config.generators do |g|
      g.orm :neo4j
    end

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_paths << Rails.root.join('app/models')
    config.autoload_paths << Rails.root.join('lib')

    # Configure where the embedded neo4j database should exist
    # Notice embedded db is only available for JRuby
    # config.neo4j.session_type = :embedded_db  # default #server_db
    # config.neo4j.session_path = File.expand_path('neo4j-db', Rails.root)

    #config.neo4j.session_path = 'http://neo4j:p2ep@localhost:7100'
    #config.neo4j.session_options = {initialize: { ssl: { verify: false }}}

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
