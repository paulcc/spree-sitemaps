class SitemapController < Spree::BaseController
  def index
    config
    @root_taxons = Taxonomy.all.map &:root
    respond_to do |format|
      format.html { }
      format.xml  { render :layout => false, :template => 'sitemap/index.xml.erb' }
      format.text { render :text => [""].concat(Product.all.map {|p| product_path p}).map {|l| @public_dir + l}.join("\x0a") }
    end
  end

  # showing the sitemap of a specific taxon, to cut down on sitemap size
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

  def home
    config
    respond_to do |format|
      format.xml  { render :layout => false, :template => 'sitemap/home.xml.erb' }
    end
  end

  private
  def config
    # not using :site_url because localhost etc is more useful in dev mode
    @public_dir = url_for( :controller => '/' ).sub(%r|/\s*$|, '') 

    # only show a product once in the whole sitemap
    @allow_duplicates = false # TODO: config setting

    # default to this to avoid penalties for lack of changes
    @change_freq = 'monthly' 
  end


end
