module SitemapHelper

  def sub_xml(xml, taxon, tree)		# check no taxon link?
    tree.first.each do |p|
      xml.url {
        xml.loc (@public_dir + '/products/' + p.permalink)                 # was seo_url(taxon, p)
        xml.lastmod p.updated_at.xmlschema			  #change timestamp of last modified
        xml.changefreq 'weekly'
        xml.priority '0.8'
      } 
    end
    tree.last.each do |k, v| 
      sub_xml(xml, k, v)
    end
  end

  def sub_html(xml, taxon, tree)
    xml.p { xml.b { xml.a taxon.name.upcase, :href => seo_url(taxon) }}
    xml.ul {
      tree.first.map do |p|
        xml.li { xml.a p.name, :href => '/products/' + p.permalink }     # keep simple, was seo_url(taxon, p)
      end
    }
    xml.ul {
      tree.last.each do |k, v| 
        xml.li { sub_html(xml, k, v) }
      end
    }
  end
end
