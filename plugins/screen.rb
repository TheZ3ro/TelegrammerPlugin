class ScreenPlugin < TelegrammerPlugin

  def self.help
    '"/screen": Take a screenshot on bot system'
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="screen"
      if AdminPlugin.is_admin?(message.from.username)
        p "Command received #{cmd}"
        path = File.join(TelegrammerPlugin::TMP,"scrot.jpg")
        tmp=%x[scrot -z #{path}]
        if File.exist?(path)
          File.open(path){ |f|
            bot.send_photo(chat_id: message.chat.id, photo: f)
          }
          File.delete(path)
        else
          puts "Error:".red+" File not exist #{path}"
        end
      else
        bot.send_message(chat_id: message.chat.id, text: "Only an admin can execute this command")
      end
    end
  end

end
