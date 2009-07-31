# map.resources :sitemap
map.nested_taxons '/sitemap.:format',             :controller => 'sitemap', :action => 'index'
map.nested_taxons '/sitemap/*id/sitemap.:format', :controller => 'sitemap', :action => 'show'
map.nested_taxons '/sitemap/home.xml',            :controller => 'sitemap', :action => 'home'

