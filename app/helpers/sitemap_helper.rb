module SitemapHelper

  def add_taxon_products xml, taxon
    taxon.products.select {|p| @allow_duplicates || p.taxons.first == taxon }.each do |p|
      xml.url {
        xml.loc (@public_dir + product_path(p))
        xml.lastmod p.updated_at.xmlschema                        #change timestamp of last modified
        xml.changefreq 'weekly'
        xml.priority '0.8'
      }
    end
  end

  def add_taxon_descendants xml, taxon
    taxon.children.each do |k|
      xml.sitemap {
        xml.loc (@public_dir + '/sitemap/' + k.permalink + 'show.xml')
        xml.lastmod k.updated_at.xmlschema
      }
      add_taxon_descendants xml, k
    end
  end

  # recursive traversal
  def sub_html(xml, taxon)
    xml.p { xml.b { xml.a taxon.name.upcase, :href => seo_url(taxon) }}
    xml.ul {
      taxon.products.select {|p| @allow_duplicates || p.taxons.first == taxon }.map do |p|
        xml.li { xml.a p.name, :href => product_path(p) }	# use basic form
      end
    }
    xml.ul {
      taxon.children.each do |k|
        xml.li { sub_html(xml, k) }
      end
    }
  end
end
