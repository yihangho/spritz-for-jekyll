module Spritz
  module Tags
    def get_site(environments)
      @site = nil
      environments.each do |e|
        if e.has_key?("site")
          return @site = e["site"]
        end
      end
    end

    def get_options
      @options = {}
      sanitize_options(@site)

      @options[:client_id]     = @site["spritz_client_id"]
      @options[:url]           = @site["url"]
      @options[:login_success] = @site["spritz_login_success_name"]
      @options[:selector]      = @site["spritz_selector"]
    end

    def sanitize_options(config)
      return unless config["url"]

      if config[config["url"]]
        config["url"] = config[config["url"]]
      end

      unless /https?:\/\// =~ config["url"]
        config["url"] = "http://" + config["url"]
        puts "Spritz for Jekyll: URL does not contain protocol. We will use HTTP by default."
      end

      if /\/$/ =~ config["url"]
        config["url"].gsub!(/\/+$/, "")
        puts "Spritz for Jekyll: URL ends with a forward slash. We will remove it for you."
      end
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
    end
  end
end
