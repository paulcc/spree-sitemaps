module SitemapHelper

  def add_taxon_products xml, taxon
    products_to_list = listable_product_ids(taxon)
    products_to_list.each do |p|
      xml.url {
        p = Product.find(p)
        xml.loc (@public_dir + product_path(p))
        xml.lastmod p.updated_at.xmlschema                        #change timestamp of last modified
        xml.changefreq @change_freq
        xml.priority '0.8'
      }
    end
  end

  # access the count or the actual products to be listed
  def listable_product_ids(taxon, select = "DISTINCT id")
    opts = {:select => select}
    unless @allow_duplicates
      # only list where taxon is the first listed one for the product
      # this is possibly dubious if retrieval is non-deterministic
      opts[:conditions] = "taxon_id = (select taxon_id from products_taxons where product_id = products.id limit 1)"
    end
    taxon.products.find(:all, opts)
  end

  def add_sub_map xml,taxon
    xml.sitemap {
      xml.loc (@public_dir + '/sitemap/' + taxon.permalink + 'sitemap.xml')
      xml.lastmod taxon.updated_at.xmlschema
    }
  end

  # returns tree of descendents with their listable count
  def get_taxon_descendants taxon
    taxon.children.map do |k|
      count = listable_product_ids(k, "count(*) as count").first.count.to_i 
      all_info = get_taxon_descendants(k) 
      all_info += [k, count] if count != 0
      all_info
    end
  end

  # recursive traversal
  def sub_html(xml, taxon)
    xml.p { xml.b { xml.a taxon.name.upcase, :href => seo_url(taxon) }}
    xml.ul {
      listable_products(taxon).map do |p|
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
