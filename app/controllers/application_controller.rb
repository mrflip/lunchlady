class ApplicationController < ActionController::Base
  protect_from_forgery

  ActiveRecord::Base.logger = Rails.logger

  # require_dependency(File.join(Rails.root, 'vendor/plugins/ajaxful_rating/lib/axr/model'))
end
