class HelpPlugin < TelegrammerPlugin

  def self.help
    '"/help": This error message'
  end

  def self.beauty(s)
    b=s.split(':')
    # Strip first 2 char and last
    # Split command and params and select only the command
    b[0]=b[0][2..-2].split(' ')[0]
    b.join(' -')
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="help"
      p "Command received #{cmd}"
      m=""
      TelegrammerPlugin.plugins.each do |plugin|
        if params[0]=="BotFather"
          m+=beauty(plugin.help)+"\n"
        else
          m+=plugin.help+"\n"
        end
      end
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
      TelegrammerPlugin.pchat(message.chat.id,m,"")
    end
  end

  private_class_method :beauty
end
