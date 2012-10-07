class UserSweeper < ActionController::Caching::Sweeper
  observe User

  def after_save(site)
    UserSweeper.sweep
  end
  
  def self.sweep
    cache_dir = ActionController::Base.page_cache_directory
    unless cache_dir == "#{RAILS_ROOT}/public"
      FileUtils.rm_r(Dir.glob("#{cache_dir}/*")) rescue Errno::ENOENT
      Rails.logger.info "Cache directory `#{cache_dir}' was swept."
    end
  end
end
