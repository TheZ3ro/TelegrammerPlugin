class EchoPlugin < TelegrammerPlugin

  def self.help
    '"/echo <text...>": Repeat the text'
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="echo")
      p "Command received #{cmd}"
      m="#{params.join(' ')}"
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
    end
  end

end
