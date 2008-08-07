require 'rubygems'
require 'templater'
require 'yaml'
require 'mash'

module Confiture
  
  class ConfitureError < StandardError #:nodoc:
  end
  class UninitializedError < ConfitureError #:nodoc:
  end
  class ConfigError < ConfitureError #:nodoc:
  end

end

dir = File.join(File.dirname(__FILE__), 'confiture/')

require dir + 'confiture'
require dir + 'cli'
require dir + 'config'
require dir + 'generators/base'
require dir + 'generators/stub'
require dir + 'generators/config'