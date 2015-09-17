class EchoPlugin < TelegrammerPlugin

  def self.help
    '"/echo <text...>": Repeat the text'
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="echo")
      p "Command received #{cmd}"
      m="#{params.join(' ')}"
      if(!m.nil? && !m.empty?)
        bot.send_message(chat_id: message.chat.id, text: "#{m}")
        TelegrammerPlugin.pchat(message.chat.id,m,"")
      else
        bot.send_message(chat_id: message.chat.id, text: "Error: \n"+self.help)
        TelegrammerPlugin.pchat(message.chat.id,"Error: \n"+self.help,"")
      end
    end
  end

end
