module Spritz
  def self.script_tag(client_id, base_url, login_success)
    output = <<-HEREDOC
      <script>
        window.jQuery || document.write('<script src=\"//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js\">\\x3C/script>');
        var SpritzSettings = {
          clientId: \"#{client_id}\",
          redirectUri: \"#{base_url}/#{login_success}\"
        };
        if (!(/^https?:\\/\\//i.test(SpritzSettings.redirectUri))) {
          SpritzSettings.redirectUri = window.location.protocol + "//" + window.location.host + SpritzSettings.redirectUri;
        }
      </script>
      <script id=\"spritzjs\" type=\"text/javascript\" src=\"//sdk.spritzinc.com/js/1.0/js/spritz.min.js\"></script>
    HEREDOC
    output.gsub(/^\s*/, "")
  end

  def self.redicle_tag(options = {})
    # Set default options
    options["data-role"] = "spritzer"
    attributes = Spritz::get_attribute_string(options)
    "<p><div #{attributes}></div></p>"
  end

  def self.get_attribute_string(options)
    attributes = ""
    options.each do |k, v|
      next unless k and v
      attributes += " " unless attributes.empty?
      attributes += "#{k} = \"#{v}\""
    end
    attributes
  end
end
