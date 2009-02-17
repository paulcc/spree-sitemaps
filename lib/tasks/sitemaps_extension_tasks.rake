namespace :db do
  desc "Bootstrap your database for Spree."
  task :bootstrap  => :environment do
    # load initial database fixtures (in db/sample/*.yml) into the current environment's database
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    Dir.glob(File.join(SitemapsExtension.root, "db", 'sample', '*.{yml,csv}')).each do |fixture_file|
      Fixtures.create_fixtures("#{SitemapsExtension.root}/db/sample", File.basename(fixture_file, '.*'))
    end
  end
end

namespace :spree do
  namespace :extensions do
    namespace :sitemaps do
      desc "Copies public assets of the Sitemaps to the instance public/ directory."
      task :update => :environment do
        is_svn_git_or_dir = proc {|path| path =~ /\.svn/ || path =~ /\.git/ || File.directory?(path) }
        Dir[SitemapsExtension.root + "/public/**/*"].reject(&is_svn_git_or_dir).each do |file|
          path = file.sub(SitemapsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
      task :google_sync => :environment do
	#url = http://www.google.com/webmasters/tools/ping?sitemap=url_encode(public_dir + /sitemaps.xml)
	#wget url 
      end
      task :yahoo_sync => :environment do
        #url = http://search.yahooapis.com/SiteExplorerService/V1/ping?sitemap=url_encode(public+dir + /sitemaps.txt)
        #wget url
      end
    end
  end
end
