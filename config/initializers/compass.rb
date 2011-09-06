require 'fileutils'
stylesheets_tmp_dir = Rails.root.join("tmp", "stylesheets")
FileUtils.mkdir_p(stylesheets_tmp_dir)

Dir[Rails.root.join("public", "stylesheets", "*")].each do |f|
  FileUtils.cp(f, stylesheets_tmp_dir) if File.exists?(f) && File.file?(f)
end

Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static',
    :urls => ['/stylesheets'],
    :root => "#{Rails.root}/tmp")
