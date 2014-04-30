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
  end
end
