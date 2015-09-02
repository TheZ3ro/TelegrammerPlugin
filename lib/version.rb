class VersionPlugin < TelegrammerPlugin

  def self.help
    '"/version": Print the Bot version'
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="version"
      p "Command received #{cmd}"
      m="Telegrammer version: #{Telegrammer::VERSION}\nTelegrammerPlugin version: #{TelegrammerPlugin::VERSION}"
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
      TelegrammerPlugin.pchat(message.chat.id,m,"")
    end
  end

end
