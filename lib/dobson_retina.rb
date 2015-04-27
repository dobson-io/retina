module Dobson
end

%w{ helpers }.each do |dir|
  
  ActiveSupport::Dependencies.autoload_paths << File.join(File.dirname(__FILE__), 'app', 'helpers')
  ActiveSupport::Dependencies.autoload_paths << File.join(File.dirname(__FILE__), 'app', 'helpers', 'dobson')
  # ActiveSupport::Dependencies.autoload_once_paths.delete(File.join(File.dirname(__FILE__), 'app', 'helpers'))
  # ActiveSupport::Dependencies.autoload_once_paths.delete(File.join(File.dirname(__FILE__), 'app', 'helpers', 'dobson'))
  
  require File.join(File.dirname(__FILE__), 'app', 'helpers', 'dobson', 'retina_helper.rb')
  
end