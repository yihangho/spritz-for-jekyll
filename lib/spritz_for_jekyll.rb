module Spritz
  class Generator < Jekyll::Generator
    def initialize(*args)
      super
      login_success_name = args[0]["spritz_login_success_name"] || "login_success.html"
      File.open(File.join(args[0]["source"], login_success_name), "w") do |f|
        f << '<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1" /><title>Spritz Login Success</title></head><body><script type="text/javascript">var hash=window.location.hash,origin=window.location.protocol+"//"+window.location.host;if(typeof(localStorage)!=="undefined"){try{localStorage.setItem("spritz.authResponse",hash)}catch(e){if(console){console.log(e,"Can\'t write to localStorage")}}}if(window.opener){window.opener.postMessage(hash,origin)};</script></body></html>'
      end
    end

    def generate(site)
      return if site.config["spritz_client_id"].nil?
      return unless site.config["spritz_auto_mode"].nil? or site.config["spritz_auto_mode"]

      puts "url should be defined in order for Spritz to work." if site.config["url"].nil?

      client_id = site.config["spritz_client_id"]
      base_url  = site.config["url"]
      login_success_name = site.config["spritz_login_success_name"] || "login_success.html"

      snippet = <<HEREDOC
<script>
  window.jQuery || document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">\\x3C/script>');
  var SpritzSettings = {
    clientId: "#{client_id}",
    redirectUri: "#{base_url}/#{login_success_name}"
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
      login_success_name = site["spritz_login_success_name"] || "login_success.html"

      return if client_id.nil?
      puts "url should be defined in order for Spritz to work." if base_url.nil?

      snippet = <<HEREDOC
<script>
  window.jQuery || document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">\\x3C/script>');
  var SpritzSettings = {
    clientId: "#{client_id}",
    redirectUri: "#{base_url}/#{login_success_name}"
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
