class InfoPlugin < TelegrammerPlugin

  def self.help
    '"/info": Print the Bot information'
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="info"
      p "Command received #{cmd}"
      m="TelegrammerPlugin is Telegram Bot made on top of Telegrammer by TheZero https://github.com/TheZ3ro/TelegrammerPlugin/"
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
      TelegrammerPlugin.pchat(message.chat.id,m,"")
    end
  end

end
