require "importmap-rails"
require "turbo-rails"
require "stimulus-rails"

require "phlex"
require "phlex_icons"
require "phlex-rails"
require "rouge"
require "turbo_power"
# require "phlex_ui"

module PhlexStorybook
  class Engine < ::Rails::Engine
    isolate_namespace PhlexStorybook

    config.autoload_paths << "#{root}/lib"

    initializer "phlex_storybook.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.precompile += %w[ phlex_storybook_manifest ]
    end

    initializer "phlex_storybook.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end
  end
end
