module Confiture
  
  extend self
  
  def root
    ENV["CONFITURE_ROOT"] || "/etc/confiture"
  end
  
  def config
    Mash.new(YAML.load(config_file))
  rescue Errno::ENOENT
    raise Confiture::UninitializedError, "the configuration has not been initialized, please run 'confiture init'"
  end
  
  def app_config_for(name)
    Confiture::AppConfig.load(File.join(config.app_root, name, 'app.yml'))
  end
  
  def available_apps
    Dir.glob(File.join(config.app_root, '*', 'app.yml'))
  end
  
  def config_file
    File.read(config_path)
  end
  
  def config_path
    File.join(Confiture.root, 'config.yml')
  end
  
end