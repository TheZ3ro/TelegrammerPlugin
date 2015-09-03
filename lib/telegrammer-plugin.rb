class TelegrammerPlugin
  VERSION = "0.1.2"
  TMP = File.join(Dir.pwd,"tmp")

  # Set of plugins loaded
  @plugins = Set.new

  def self.plugins
    @plugins
  end

  #This method will load and register the plugins that derive from TelegrammerPlugin
  def self.register_plugins
    require './lib/admin.rb'
    require './lib/help.rb'
    require './lib/version.rb'
    require './lib/info.rb'
    Object.constants.each do |klass|
      if klass != :Config
        const = Object.const_get(klass)
        #If the plugin derive from TelegrammerPlugin
        if const.respond_to?(:superclass) and const.superclass == TelegrammerPlugin
          #If it has :help and :handle_command methods
          if const.methods.include?(:help) && const.methods.include?(:handle_command)
            @plugins << const
          else
            puts "Alert:".brown+" #{const} is not implemented correctly"
          end
        end
      end
    end
  end

  def self.pchat(chat_id,text,from)
    if(from=="")
      puts "#{chat_id}".green+" => @me: #{text}"
    else
      if from.username.nil? then
        puts "#{chat_id}".green+" => \"#{from.first_name}\": #{text}"
      else
        puts "#{chat_id}".green+" => @#{from.username}: #{text}"
      end
    end
  end
end
