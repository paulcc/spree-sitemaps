class SitemapController < Spree::BaseController
  def index
    @public_dir = url_for( :controller => '/' ).sub(%r|/\s*$|, '')
    @allow_duplicates = false # TODO: config setting
    @info = build_tree(@allow_duplicates)

    respond_to do |format|
      format.html { }
      format.xml  { render :layout => false, :template => 'sitemap/index.xml.erb' }
      format.text { render :text => @info.to_yaml }
    end
  end

  private

  # build a hash of results from all of the taxonomies
  # can't use Hash[...flatten] technique here - it flattens everything
  def build_tree(allow_duplicates = false)
    table = {}
    Taxonomy.all.each do |taxonomy|  
      table[taxonomy.root] = visit(taxonomy.root,allow_duplicates) 
    end
    table
  end 

  # include a product ONLY in its first taxon if allow_duplicates is false
  # this is much easier than trying to track a visited-set
  # though is a bit fragile... (only really matters if seo_urls are used)
  def visit(taxon, allow_duplicates)
    table = {} 
    taxon.children.each {|t| table[t] = visit(t, allow_duplicates) }
    [ taxon.products.select {|p| allow_duplicates || p.taxons.first == taxon }, table ]
  end

end
