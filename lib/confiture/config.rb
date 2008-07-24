module Confiture

  class Config
    
    attr_reader :conf
        
    def self.load(yaml_file)
      self.new(YAML.load(yaml_file))
    end
    
    protected
    
    def method_missing(*args)
      conf.send(*args)
    end
  end

  class AppConfig < Config
    
    REQUIRED_ATTRIBUTES = [:name]
  
    def initialize(conf = {})
      @conf = Mash.new(conf)
      REQUIRED_ATTRIBUTES.each do |attribute|
        raise Confiture::ConfigError, "required attribute '#{attribute}' not given" unless @conf[attribute]
      end
      
      @conf.kind ||= "rails"
      @conf.servers ||= 1
      @conf.ports ||= ((@conf.port)..(@conf.port + @conf.servers - 1)).to_a if @conf.port
      @conf.uid ||= @conf.name
      @conf.gid ||= @conf.name
      
      @conf.cwd ||= Confiture.config.app_root + '/' + @conf.name + "/current"
      @conf.docroot ||= @conf.cwd + "/public"
      @conf.address ||= "127.0.0.1"
      @conf.balancer_name ||= "balancer://#{@conf.name}_cluster"
      
      @conf.hosts ||= []
      @conf.hosts = @conf.hosts.map { |host| HostConfig.get(@conf, host) }
      @conf.hosts << HostConfig.get(@conf, @conf.host) if @conf.host
    end
  
  end
  
  class HostConfig < Config
  
    attr_reader :app_conf
  
    def initialize(app_conf, conf)
      @conf = Mash.new(conf)
      @app_conf = Mash.new(app_conf)
      
      @conf.name ||= "default"
      @conf.host ||= "*"
      @conf.port ||= 80
      @conf.kind ||= "http"
      @conf.aliases ||= []
      
      @conf.error_log ||= "#{APACHE_LOG_ROOT}/#{@app_conf.name}_#{@conf.name}_errors.log"
      @conf.log ||= "#{APACHE_LOG_ROOT}/#{@app_conf.name}_#{@conf.name}.log"
      
      @conf.cert_file ||= "#{APACHE_SSL_ROOT}/#{@app_conf.name}.crt"
      @conf.key_file ||= "#{APACHE_SSL_ROOT}/#{@app_conf.name}.key"
      
      @conf = conf
    end
  
  end
  
end