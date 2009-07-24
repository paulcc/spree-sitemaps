# map.resources :sitemap
map.nested_taxons '/sitemap.:format',          :controller => 'sitemap', :action => 'index'
map.nested_taxons '/sitemap/*id/show.:format', :controller => 'sitemap', :action => 'show'

