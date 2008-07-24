module Confiture
  
  class CLI
    
    def self.run(args)
      self.new.run(args)
    end
    
    def run(args)
      command = args.shift
      case command
      when "init"
        #Templater::CLI::Generator.run(...)
      end
    end
    
  end
  
end