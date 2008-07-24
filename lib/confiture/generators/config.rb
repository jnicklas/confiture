module Confiture

  class ConfigGenerator < Generator
    
    def self.source_root
      File.join(File.dirname(__FILE__), '..', '..', 'templates')
    end
    
    glob!(nil, [])
    
  end
  
  add :config, ConfigGenerator
  
end