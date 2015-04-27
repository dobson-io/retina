require 'active_support/ordered_options'
require 'rails/railtie'
require 'dimensions'


module Dobson
  module RetinaHelper
    
    
    include ActionView::Helpers::AssetUrlHelper

    RES_VERSIONS = {
      "" => 1,
      "@2x" => 2,
      "@3x" => 3,
      "@4x" => 4,
    }

    def allow_cache?
      !Rails.env.development?
    end

    def retina_img(source, options = {})

      # Init 
      ret = []
      @@_cached ||= {}
      nat_width = options[:width] || nil
      nat_height = options[:height] || nil
      cache_key = "#{source}:#{options.hash}"
    
      # Have we injected the support script yet? 
      if !options[:ignore_support] && !@_supported 
        ret << "<script>"
        ret << IO.read(File.expand_path("../../../assets/javascripts/dobson/retina.js", __FILE__))
        ret << "</script>"
        @_supported = true;
      end
    
      # Have we hanlded this source before? if so, act fast... 
      if @@_cached[cache_key] && allow_cache?
        # use the cached version.. 
        ret << @@_cached[cache_key]
      else
        
        # Init
        versions = []
        re = source.match(/^(.+)\.(.+?)$/);
        source_path = re[1]
        source_ext = re[2]
        
        # Get base image dimensions... 
        if nat_width.nil? and nat_height.nil?
          fs_path = ::Rails.application.assets.find_asset(source)
          if fs_path.present? && File.exists?(fs_path.pathname)
            nat_width, nat_height = Dimensions.dimensions(fs_path.pathname)
          else
            throw "image not found: #{source}"
          end
        end
        
        # Get high res versions
        RES_VERSIONS.each_pair do |suffix, mult|
          
          s = "#{source_path}#{suffix}.#{source_ext}"
          fs_path = ::Rails.application.assets.find_asset(s)
          if fs_path.present?
            fs_path = fs_path.pathname
            versions << [mult, image_path(s)]
          end
        end
        
        # Cache it up
        v =  "<script>dobson.ri(#{nat_width || 'null'},#{nat_height || 'null'},#{versions.to_json()});</script>"
        @@_cached[cache_key] = v if allow_cache?
        ret << v

      end
      
      # Done
      return ret.join("\n").html_safe
      
    end
    
  
    alias_method :retina_image, :retina_img

  end
  
  
  # Autoload Helper... 
  class Railtie < ::Rails::Railtie
    initializer 'dobson.retina.initialize' do
      ActiveSupport.on_load(:action_view) do
        include ::Dobson::RetinaHelper
      end
    end
  end
  
end