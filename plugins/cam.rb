class CamPlugin < TelegrammerPlugin

  def self.help
    '"/cam": Take a webcam-shot on the bot system'
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="cam"
      if AdminPlugin.is_admin?(message.from.username)
        p "Command received #{cmd}"
        path = File.join(TelegrammerPlugin::TMP,"web-cam-shot.jpg")
        tmp=%x[fswebcam -q -r 640x480 --jpeg 85 -D 1 #{path}]
        if File.exist?(path)
          File.open(path){ |f|
            bot.send_photo(chat_id: message.chat.id, photo: f)
            TelegrammerPlugin.pchat(message.chat.id,"*photo*","")
          }
          File.delete(path)
        else
          puts "Error:".red+" File not exist #{path}"
        end
      else
        bot.send_message(chat_id: message.chat.id, text: "Only an admin can execute this command")
        TelegrammerPlugin.pchat(message.chat.id,"Only an admin can execute this command","")
      end
    end
  end

end
