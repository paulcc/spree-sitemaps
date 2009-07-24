SUMMARY
=======

This extension creates sitemaps in .html, .txt, and .xml (google sitemap) formats.


Formats
-------

The XML format is explained here: http://www.sitemaps.org/protocol.php

Note that we're using the sitemaplist format for the main file. Every taxon has generates a list of its own products, 
so the main list is the list of all taxon sitemaps. 

The HTML format is effectively the taxon tree, where each node shows the products associated with it. 

In HTML and XML modes, a product is only listed (by default) for its first taxon, but you can get it to appear in 
all of its taxons by setting @allow_duplicates to true.

Yahoo text formats explained here: http://help.yahoo.com/l/us/yahoo/search/siteexplorer/manage/siteexplorer-45.html
(do we need to change the filename?)

You can also include a "Sitemap: /sitemap.xml" line in your robots.txt file; some crawlers accept this hint. 
 

INSTALLATION
------------

1. Clone the git repo to SPREE_ROOT/vendor/extensions/sitemaps

      git clone git://github.com/stephp/spree-sitemaps.git sitemaps

2. Add link to sitemap to shared element on frontend. For example, I have add '<p><%= link_to 'Sitemap', '/sitemap.html' %></p>' to shared/_footer.html.erb.

3. Sitemap is accessible at public_domain/sitemap.html, public_domain/sitemap.xml, and public_domain/sitemap.txt

Refer to [spree: ruby on rails ecommerce][1] to learn more about spree.

[1]: http://spreecommerce.com/
