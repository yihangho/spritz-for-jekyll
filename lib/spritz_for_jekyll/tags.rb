module Spritz
  class SpritzScriptTag < Liquid::Tag
    include Spritz
    include Spritz::Tags

    def render(context)
      get_site(context.environments)
      return if @site.nil?
      get_options(@site)
      warn_and_set_default
      Spritz::script_tag(@options[:client_id], @options[:url], @options[:login_success])
    end
  end

  class SpritzRedicleTag < Liquid::Tag
    include Spritz
    include Spritz::Tags

    def render(context)
      get_site(context.environments)
      return if @site.nil?
      get_options(@site)
      warn_and_set_default
      Spritz::redicle_tag("data-selector" => @options[:selector])
    end
  end
end

Liquid::Template.register_tag('spritz_scripts', Spritz::SpritzScriptTag)
Liquid::Template.register_tag('spritz_redicle', Spritz::SpritzRedicleTag)
