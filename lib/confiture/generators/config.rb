module Confiture

  class ConfigGenerator < Generator
    
    def self.source_root
      File.join(File.dirname(__FILE__), '..', '..', 'templates')
    end
    
    first_argument :name, :required => true, :desc => "Name of the Application"
    option :god, :as => :boolean
    option :kind, :default => :rails
    option :apache, :as => :boolean
    option :proxied, :as => :boolean
    option :proxy_clustered, :as => :boolean
    
    template :god_rails, :god => true, :kind => :rails do
      source('god/rails.god')
      destination(Confiture.config.god_config_root, "#{name}.god")
    end
    
    template :god_merb, :god => true, :kind => :merb do
      source('god/merb.god')
      destination(Confiture.config.god_config_root, "#{merb}.god")
    end
    
    template :apache_proxied, :apache => true, :proxied => true do
      source('apache/proxied.common')
      destination(Confiture.config.apache_config_root, "#{name}.common")
    end
    
    template :apache_proxy_clustered, :apache => true, :proxy_clustered => true do
      source('apache/proxy_clustered.common')
      destination(Confiture.config.apache_config_root, "#{name}.common")
    end
    
    template :apache_proxy_cluster, :apache => true, :proxy_clustered => true do
      source('apache/proxy_cluster.conf')
      destination(Confiture.config.apache_config_root, "#{name}_cluster.conf")
    end
    
  end
  
  add :config, ConfigGenerator
  
end