require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Beacon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = "Pacific Time (US & Canada)"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("lib")

    # TODO: Use railtie as soon as graphql-client is fixed for Rails 5
    config.graphql = ActiveSupport::OrderedOptions.new

    initializer "graphql.configure_log_subscriber" do |_app|
      require "graphql/client/log_subscriber"
      GraphQL::Client::LogSubscriber.attach_to :graphql
    end

    initializer "graphql.configure_erb_implementation" do |_app|
      require "graphql/client/erubi_enhancer"
      ActionView::Template::Handlers::ERB::Erubi.include(GraphQL::Client::ErubiEnhancer)
    end

    initializer "graphql.configure_views_namespace" do |app|
      require "graphql/client/view_module"

      path = app.paths["app/views"].first

      client = Graph.client

      config.watchable_dirs[path] = [:erb]

      Object.const_set(:Views, Module.new do
       extend GraphQL::Client::ViewModule
        self.path = path
        self.client = client
      end)
    end
  end
end
