load 'axr/locale.rb'
load 'axr/errors.rb'
load 'axr/model.rb'
load 'axr/css_builder.rb'
load 'axr/stars_builder.rb'
load 'axr/helpers.rb'
module AjaxfulRating
  autoload :ClassMethods,    'axr/model'
  autoload :InstanceMethods, 'axr/model'
  autoload :Errors,          'axr/errors'
end
