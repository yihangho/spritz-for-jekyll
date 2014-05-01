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

  def self.sanitize_options(config)
    return unless config["spritz"] && config["spritz"]["url"]

    if config[config["spritz"]["url"]]
      config["spritz"]["url"] = config[config["spritz"]["url"]]
    end

    unless /https?:\/\// =~ config["spritz"]["url"]
      config["spritz"]["url"] = "http://" + config["spritz"]["url"]
      puts "Spritz for Jekyll: URL does not contain protocol. We will use HTTP by default."
    end

    if /\/$/ =~ config["spritz"]["url"]
      config["spritz"]["url"].gsub!(/\/+$/, "")
      puts "Spritz for Jekyll: URL ends with a forward slash. We will remove it for you."
    end
  end

  private
  def get_options(config)
    @options = {}
    Spritz::sanitize_options(config)

    @options[:client_id]     = config["spritz"]["client_id"]
    @options[:url]           = config["spritz"]["url"]
    @options[:login_success] = config["spritz"]["login_success_name"]
    @options[:selector]      = config["spritz"]["selector"]
    @options[:automode]      = config["spritz"]["auto_mode"]
  end

  def warn_and_set_default
    if @options[:client_id].nil?
      puts "Spritz for Jekyll: You need a client ID!"
      @options[:client_id] = "12345"
    end

    if @options[:url].nil?
      puts "Spritz for Jekyll: URL not set. Will guess on client side."
    end

    if @options[:login_success].nil?
      @options[:login_success] = "login_success.html"
    end

    if @options[:automode].nil?
      @options[:automode] = true
    end
  end
end
