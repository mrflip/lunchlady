module ActionDispatch
  class Static

    def call(env)
      path   = env['PATH_INFO'].chomp('/')
      method = env['REQUEST_METHOD']

      if FILE_METHODS.include?(method)
        if file_exist?(path)
          st, hd, bo = @file_server.call(env)
          hd['Cache-Control'] ||= "public, max-age=86400"
          return [st, hd, bo]
        else
          cached_path = directory_exist?(path) ? "#{path}/index" : path
          cached_path += ::ActionController::Base.page_cache_extension

          if file_exist?(cached_path)
            env['PATH_INFO'] = cached_path
            st, hd, bo = @file_server.call(env)
            hd['Cache-Control'] ||= "public, max-age=86400"
            return [st, hd, bo]
          end
        end
      end

      @app.call(env)
    end
  end
end
