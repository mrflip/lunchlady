class ApplicationController < ActionController::Base
  protect_from_forgery

  ActiveRecord::Base.logger = Rails.logger
  ActiveRecord::Base.clear_active_connections!

  Rails.logger.debug( [ __FILE__, Rails.logger, ActiveRecord::Base.logger, Rails.logger.level ])

  # require_dependency(File.join(Rails.root, 'vendor/plugins/ajaxful_rating/lib/axr/model'))
end
