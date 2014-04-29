module Spritz
  class Generator < Jekyll::Generator
    def initialize(*args)
      super
      login_success_path = args[0]["spritz_login_success_name"] || "login_success.html"
      dirname = File.dirname(login_success_path)

      FileUtils.mkdir_p(dirname)

      source = File.join(File.dirname(__FILE__), "..", "login_success.html")
      destination = File.join(args[0]["source"], login_success_path)
      FileUtils.copy(source, destination)
    end

    def generate(site)
      get_options(site.config)
      warn_and_set_default
      return unless @options[:automode]

      snippet =  Spritz::script_tag(@options[:client_id], @options[:url], @options[:login_success])
      snippet += Spritz::redicle_tag("data-selector" => @options[:selector])

      site.posts.each do |p|
        p.content = snippet + p.content if p.data["spritz"].nil? or p.data["spritz"]
      end
    end

    private

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

    def get_options(config)
      @options = {}
      sanitize_options(config)

      @options[:client_id]     = config["spritz_client_id"]
      @options[:url]           = config["url"]
      @options[:login_success] = config["spritz_login_success_name"]
      @options[:selector]      = config["spritz_selector"]
      @options[:automode]      = config["spritz_auto_mode"]
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
end
