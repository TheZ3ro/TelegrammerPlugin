class VersionPlugin < TelegrammerPlugin

  def handle_command(cmd,params,bot,message)
    p "#{message.text} #{cmd}"
    if(cmd=="version")
      p "Command received #{cmd}"
      m="Telegrammer version: #{Telegrammer::VERSION}\nTelegrammerPlugin version: #{TelegrammerPlugin::VERSION}"
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
    end
  end

end
