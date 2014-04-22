module Spritz
  class Generator < Jekyll::Generator
    def generate(site)
      return if site.config["spritz_client_id"].nil?

      puts "url should be defined in order for Spritz to work." if site.config["url"].nil?

      client_id = site.config["spritz_client_id"]
      base_url = site.config["url"]

      snippet = <<HEREDOC
<script>
  window.jQuery || document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">\\x3C/script>');
  var SpritzSettings = {
    clientId: "#{client_id}",
    redirectUri: "#{base_url}/login_success.html"
  };
</script>
<script id="spritzjs" type="text/javascript" src="//sdk.spritzinc.com/js/1.0/js/spritz.min.js"></script>
<p><div data-role="spritzer"></div></p>
HEREDOC

      site.posts.each do |p|
        p.content = snippet + p.content if p.data["spritz"].nil? or p.data["spritz"]
      end
    end
  end

  class SpritzScriptTag < Liquid::Tag
    def render(context)
      site = get_site(context.environments)
      return if site.nil?

      client_id = site["spritz_client_id"]
      base_url  = site["url"]

      return if client_id.nil?
      puts "url should be defined in order for Spritz to work." if base_url.nil?

      snippet = <<HEREDOC
<script>
  window.jQuery || document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">\\x3C/script>');
  var SpritzSettings = {
    clientId: "#{client_id}",
    redirectUri: "#{base_url}/login_success.html"
  };
</script>
<script id="spritzjs" type="text/javascript" src="//sdk.spritzinc.com/js/1.0/js/spritz.min.js"></script>
HEREDOC
    end

    private

    def get_site(environments)
      environments.each do |e|
        if e.has_key?("site")
          return e["site"]
        end
      end
    end
  end

  class SpritzRedicleTag < Liquid::Tag
    def render(context)
      "<p><div data-role=\"spritzer\"></div></p>"
    end
  end
end

Liquid::Template.register_tag('spritz_scripts', Spritz::SpritzScriptTag)
Liquid::Template.register_tag('spritz_redicle', Spritz::SpritzRedicleTag)
