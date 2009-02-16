# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SitemapsExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/sitemaps"

  # Please use sitemaps/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    # admin.tabs.add "Spree Sitemaps", "/admin/sitemaps", :after => "Layouts", :visibility => [:all]
  end
end
