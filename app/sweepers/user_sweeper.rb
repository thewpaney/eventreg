class UserSweeper < ActionController::Caching::Sweeper
  def self.sweep
    cache_dir = ActionController::Base.page_cache_directory
    unless cache_dir == "#{Rails.root}/public"
      FileUtils.rm_r(Dir.glob("#{cache_dir}/*")) rescue Errno::ENOENT
      Rails.logger.info "Cache directory `#{cache_dir}' was swept."
    end
  end
end
