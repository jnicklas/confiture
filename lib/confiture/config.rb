module Confiture

  class Config < Hash
    def self.load(yaml_file)
      self.new(YAML.load(yaml_file))
    end
    
    def method_missing(method, *args)
      if args.empty? and self.has_key?(method.to_s)
        return self[method.to_s]
      else
        super
      end
    end
  end

  class AppConfig < Config
  
    def initialize(conf)
      super(conf)
      self["kind"] ||= "rails"
      self["ports"] ||= ((self.port)..(self.port + self.servers - 1)).to_a if self["port"]
      self["uid"] ||= self["name"]
      self["gid"] ||= self["name"]
      self["cwd"] ||= APP_ROOT + '/' + self["name"] + "/current"
      self["docroot"] ||= self["cwd"] + "/public"
      self["address"] ||= "127.0.0.1"
      self["balancer_name"] ||= "balancer://#{self.name}_cluster"
      
      self["hosts"] ||= []
      self["hosts"] = self["hosts"].map { |host| HostConfig.new(self, host) }
      self["hosts"] << HostConfig.new(self, self["host"]) if self["host"]
    end
  
  end
  
  class HostConfig < Config
  
    def initialize(app_conf, conf)
      super(conf)

      self["name"] ||= "default"
      self["host"] ||= "*"
      self["port"] ||= 80
      self["kind"] ||= "http"
      self["aliases"] ||= []

      self["error_log"] ||= "#{APACHE_LOG_ROOT}/#{self.app_conf.name}_#{self.name}_errors.log"
      self["log"] ||= "#{APACHE_LOG_ROOT}/#{self.app_conf.name}_#{self.name}.log"

      self["cert_file"] ||= "#{APACHE_SSL_ROOT}/#{self.app_conf.name}.crt"
      self["key_file"] ||= "#{APACHE_SSL_ROOT}/#{self.app_conf.name}.key"
    end
  
  end
  
end