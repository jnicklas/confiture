module Confiture
  
  extend Templater::Manifold
  
  class Generator < Templater::Generator
    
    def self.source_root
      Confiture.root
    end
    
  end
  
end