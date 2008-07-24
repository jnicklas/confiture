require 'rubygems'
require 'templater'
require 'yaml'
require 'mash'

dir = File.join(File.dirname(__FILE__), 'confiture/')

require dir + 'cli'
require dir + 'config'
require dir + 'generators/base'
require dir + 'generators/stub'
require dir + 'generators/config'

module Confiture
  
  class ConfitureError < StandardError #:nodoc:
  end
  class UninitializedError < ConfitureError #:nodoc:
  end
  class ConfigError < ConfitureError #:nodoc:
  end
  
  extend self
  
  def root
    ENV["CONFITURE_ROOT"] || "/etc/confiture"
  end
  
  def config
    Mash.new(YAML.parse(config_file))
  rescue Errno::ENOENT
    raise Confiture::UninitializedError, "the configuration has not been initialized, please run 'confiture init'"
  end
  
  def config_file
    File.read(config_path)
  end
  
  def config_path
    File.join(Confiture.root, 'config.yml')
  end
  
end