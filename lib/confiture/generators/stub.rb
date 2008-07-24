module Confiture

  class StubGenerator < Generator
    
    def self.source_root
      File.join(File.dirname(__FILE__), '..', '..', 'templates')
    end
    
    glob!(nil, [])
    
  end
  
  add :stub, StubGenerator
  
end