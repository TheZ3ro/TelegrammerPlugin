class PingPlugin < TelegrammerPlugin

  def self.help
    '"/ping": Check if the bot is online'
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="ping")
      p "Command received #{cmd}"
      bot.send_message(chat_id: message.chat.id, text: "pong")
      TelegrammerPlugin.pchat(message.chat.id,"pong","")
    end
  end

end
