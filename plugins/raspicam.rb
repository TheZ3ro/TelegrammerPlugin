class RaspiCamPlugin < TelegrammerPlugin

  def self.help
    '"/raspicam": Take a webcam-shot with the RaspberryPi'
  end

  def self.handle_command(cmd,params,bot,message)
    if cmd=="raspicam"
      if AdminPlugin.is_admin?(message.from.username)
        p "Command received #{cmd}"
        path = File.join(TelegrammerPlugin::TMP,"web-cam-shot.jpg")
        tmp=%x[raspistill -w 800 -h 600 -o #{path}]
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
