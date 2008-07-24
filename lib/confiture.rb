require 'templater'
require 'yaml'

module Confiture
  
  class UninitializedError < StandardError #:nodoc:
  end
  
  extend self
  
  def root
    ENV["CONFITURE_ROOT"] || "/etc/confiture"
  end
  
  def config
    YAML.parse(File.read(File.join(Confiture.root, 'config.yml')))
  rescue Errno::ENOENT
    raise Confiture::UninitializedError, "the configuration has not been initialized, please run 'confiture init'"
  end
  
  class Generator < Templater::Generator
    
    def self.source_root
      Confiture.root
    end
    
  end
  
end

dir = File.join(File.dirname(__FILE__), 'confiture/')

require dir + 'stub_generator'