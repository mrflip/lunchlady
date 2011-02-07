# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ajaxful_rating_jquery}
  s.version = "2.2.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jack Chu, Edgar J. Suarez"]
  s.date = %q{2010-09-30}
  s.description = %q{Provides a simple way to add rating functionality to your application. This is a fork of ajaxful_ratings that works with jQuery instead of Prototype and uses unobtrusive javascript instead of link_to_remote.}
  s.email = %q{kamuigt@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "README.textile", "lib/ajaxful_rating_jquery.rb", "lib/axr/css_builder.rb", "lib/axr/errors.rb", "lib/axr/helpers.rb", "lib/axr/locale.rb", "lib/axr/model.rb", "lib/axr/stars_builder.rb"]
  s.files = ["CHANGELOG", "Manifest", "README.textile", "Rakefile", "ajaxful_rating_jquery.gemspec", "generators/ajaxful_rating/USAGE", "generators/ajaxful_rating/ajaxful_rating_generator.rb", "generators/ajaxful_rating/templates/images/star.png", "generators/ajaxful_rating/templates/images/star_medium.png", "generators/ajaxful_rating/templates/images/star_small.png", "generators/ajaxful_rating/templates/migration.rb", "generators/ajaxful_rating/templates/model.rb", "generators/ajaxful_rating/templates/style.css", "init.rb", "lib/ajaxful_rating_jquery.rb", "lib/axr/css_builder.rb", "lib/axr/errors.rb", "lib/axr/helpers.rb", "lib/axr/locale.rb", "lib/axr/model.rb", "lib/axr/stars_builder.rb"]
  s.homepage = %q{http://github.com/kamui/ajaxful_rating_jquery}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ajaxful_rating_jquery", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ajaxful_rating_jquery}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Add star rating functionality to your Rails 2.3.x application. Requires jQuery.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
