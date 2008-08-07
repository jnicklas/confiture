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
    
    def init
      
    end
    
    def list
      puts "***************"
      Confiture.available_apps.each do |name|
        puts " -> #{name}"
      end
    end
    
    protected
    
    def find
      #Dir.glob()
    end
    
  end
  
end