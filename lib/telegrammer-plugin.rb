class TelegrammerPlugin
  VERSION = "0.1.0"
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
end
