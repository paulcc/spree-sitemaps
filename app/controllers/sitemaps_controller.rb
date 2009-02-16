class SitemapsController < Spree::BaseController
  def index
    respond_to do |format|
      format.html { @nav = _add_products_to_tax(_build_taxon_hash, 1) }
      format.xml { render :layout => false, :xml => _build_xml(_add_products_to_tax(_build_taxon_hash, 0)) }
      format.text do
        @nav = _add_products_to_tax(_build_taxon_hash, 0)
        render :layout => false
      end
    end
  end

  private
  def _build_xml(nav)
    returning '' do |output|
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2) 
      xml.instruct!  :xml, :version => "1.0", :encoding => "UTF-9"
      xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" ) {
        nav.each do |k, v| 
          xml.url {
            xml.loc Rails.root + v['link']
            xml.lastmod v['updated']  #change timestamp of last modified
            xml.changefreq 'weekly'
            xml.priority '0.8'
          } 
        end
      }
    end
  end

  def _build_taxon_hash
    nav = Hash.new
    Taxon.find(:all).each do |taxon|
      tinfo = Hash.new
      tinfo['name'] = taxon.name
      tinfo['depth'] = taxon.permalink.split('/').size
      tinfo['link'] = '/t/' + taxon.permalink 
      tinfo['updated'] = taxon.updated_at
      nav[taxon.permalink] = tinfo
    end
    nav
  end

  def _add_products_to_tax(nav, multiples_allowed)
    #TODO: Force active products only?
    Product.find(:all).each do |product|
      pinfo = Hash.new
      pinfo['name'] = product.name
      pinfo['link'] = '/products/' + product.permalink
      pinfo['updated'] = product.updated_at
      if multiples_allowed.nil?
        nav[p['link']] = pinfo
      else
        product.taxons.each do |taxon|
          pinfo['depth'] = taxon.permalink.split('/').size + 1
	  key = multiples_allowed ? taxon.permalink + 'p/' + product.permalink : product.permalink
          nav[taxon.permalink + 'p/' + product.permalink] = pinfo
        end
      end
    end
    nav
  end
end
