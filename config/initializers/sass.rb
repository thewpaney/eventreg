module ScssInitializer
  def self.registered(app)
    require 'sass/plugin/rack'
    Sass::Plugin.options[:syntax] = :scss
    Sass::Plugin.options[:template_location] = Padrino.root("app/stylesheets")
    Sass::Plugin.options[:css_location] = Padrino.root("public/stylesheets")
    app.use Sass::Plugin::Rack
  end
end
