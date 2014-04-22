module Spritz
  class Generator < Jekyll::Generator
    def generate(site)
      return if site.config["spritz_client_id"].nil?
      return unless site.config["spritz_auto_mode"].nil? or site.config["spritz_auto_mode"]

      puts "url should be defined in order for Spritz to work." if site.config["url"].nil?

      client_id = site.config["spritz_client_id"]
      base_url  = site.config["url"]

      snippet = <<HEREDOC
<script>
  window.jQuery || document.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">\\x3C/script>');
  var SpritzSettings = {
    clientId: "#{client_id}",
    redirectUri: "data:text/html;base64,PCFkb2N0eXBlIGh0bWw+PGh0bWw+PGhlYWQ+PG1ldGEgY2hhcnNldD0idXRmLTgiIC8+PG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIiAvPjx0aXRsZT5TcHJpdHogTG9naW4gU3VjY2VzczwvdGl0bGU+PC9oZWFkPjxib2R5PjxzY3JpcHQgdHlwZT0idGV4dC9qYXZhc2NyaXB0Ij52YXIgaGFzaD13aW5kb3cubG9jYXRpb24uaGFzaCxvcmlnaW49d2luZG93LmxvY2F0aW9uLnByb3RvY29sKyIvLyIrd2luZG93LmxvY2F0aW9uLmhvc3Q7aWYodHlwZW9mKGxvY2FsU3RvcmFnZSkhPT0idW5kZWZpbmVkIil7dHJ5e2xvY2FsU3RvcmFnZS5zZXRJdGVtKCJzcHJpdHouYXV0aFJlc3BvbnNlIixoYXNoKX1jYXRjaChlKXtpZihjb25zb2xlKXtjb25zb2xlLmxvZyhlLCJDYW4ndCB3cml0ZSB0byBsb2NhbFN0b3JhZ2UiKX19fWlmKHdpbmRvdy5vcGVuZXIpe3dpbmRvdy5vcGVuZXIucG9zdE1lc3NhZ2UoaGFzaCxvcmlnaW4pfTs8L3NjcmlwdD48L2JvZHk+PC9odG1sPg=="
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
    redirectUri: "data:text/html;base64,PCFkb2N0eXBlIGh0bWw+PGh0bWw+PGhlYWQ+PG1ldGEgY2hhcnNldD0idXRmLTgiIC8+PG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xIiAvPjx0aXRsZT5TcHJpdHogTG9naW4gU3VjY2VzczwvdGl0bGU+PC9oZWFkPjxib2R5PjxzY3JpcHQgdHlwZT0idGV4dC9qYXZhc2NyaXB0Ij52YXIgaGFzaD13aW5kb3cubG9jYXRpb24uaGFzaCxvcmlnaW49d2luZG93LmxvY2F0aW9uLnByb3RvY29sKyIvLyIrd2luZG93LmxvY2F0aW9uLmhvc3Q7aWYodHlwZW9mKGxvY2FsU3RvcmFnZSkhPT0idW5kZWZpbmVkIil7dHJ5e2xvY2FsU3RvcmFnZS5zZXRJdGVtKCJzcHJpdHouYXV0aFJlc3BvbnNlIixoYXNoKX1jYXRjaChlKXtpZihjb25zb2xlKXtjb25zb2xlLmxvZyhlLCJDYW4ndCB3cml0ZSB0byBsb2NhbFN0b3JhZ2UiKX19fWlmKHdpbmRvdy5vcGVuZXIpe3dpbmRvdy5vcGVuZXIucG9zdE1lc3NhZ2UoaGFzaCxvcmlnaW4pfTs8L3NjcmlwdD48L2JvZHk+PC9odG1sPg=="
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
