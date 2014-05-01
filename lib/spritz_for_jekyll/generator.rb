module Spritz
  class Generator < Jekyll::Generator
    include Spritz

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
      snippet += Spritz::redicle_tag("data-selector" => @options[:selector], "data-options" => @options[:redicle].to_json)

      site.posts.each do |p|
        p.content = snippet + p.content if p.data["spritz"].nil? or p.data["spritz"]
      end
    end
  end
end
