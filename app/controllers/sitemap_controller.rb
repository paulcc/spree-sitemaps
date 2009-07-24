class SitemapController < Spree::BaseController
  def index
    config
    @taxons = Taxonomy.all.map &:root
    respond_to do |format|
      format.html { }
      format.xml  { render :layout => false, :template => 'sitemap/index.xml.erb' }
      format.text { render :text => [""].concat(Product.all.map {|p| product_path p}).map {|l| @public_dir + l}.join("\x0a") }
    end
  end

  def show
    config
    @taxon = Taxon.find_by_permalink(params[:id].join("/") + "/")
    
    if @taxon.nil? 
      redirect_to sitemap_path and return
    end 

    respond_to do |format|
      format.html { }
      format.xml  { render :layout => false, :template => 'sitemap/show.xml.erb' }
      format.text { render :text => @taxon.products.map(&:name).join('\n') }		##? 
    end
  end

  private
  def config
    @public_dir = url_for( :controller => '/' ).sub(%r|/\s*$|, '')
    @allow_duplicates = false # TODO: config setting
  end


end
