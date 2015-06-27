class EchoPlugin < TelegrammerPlugin

  def handle_command(cmd,params,bot,message)
    p "#{message.text} #{cmd}"
    if(cmd=="echo")
      p "Command received #{cmd}"
      m="#{params.join(' ')}"
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
    end
  end

end
