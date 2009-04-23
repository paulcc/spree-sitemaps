SUMMARY
=======

This extension creates sitemaps in .html, .txt, and .xml (google sitemap) formats.

INSTALLATION
------------

1. Clone the git repo to SPREE_ROOT/vendor/extensions/sitemaps

      git clone git://github.com/stephp/spree-sitemaps.git sitemaps

2. Add link to sitemap to shared element on frontend. For example, I have add '<p><%= link_to 'Sitemap', '/sitemap.html' %></p>' to shared/_footer.html.erb.

3. Sitemap is accessible at public_domain/sitemap.html, public_domain/sitemap.xml, and public_domain/sitemap.txt

Refer to [spree: ruby on rails ecommerce][1] to learn more about spree.

[1]: http://spreecommerce.com/
