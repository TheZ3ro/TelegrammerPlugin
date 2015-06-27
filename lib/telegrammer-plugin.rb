class TelegrammerPlugin
  VERSION = "0.0.2"

  @plugins = Set.new

  def self.plugins
    @plugins
  end

  def self.register_plugins
    Object.constants.each do |klass|
      if klass != :Config
        const = Object.const_get(klass)
        if const.respond_to?(:superclass) and const.superclass == TelegrammerPlugin
          @plugins << const
        end
      end
    end
  end
end
