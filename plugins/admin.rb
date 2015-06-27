class AdminPlugin < TelegrammerPlugin

  def self.help
    '"/admin <admin_command> <admin_code>": a Root set of command '
  end

  def self.admin_help
    help+"\n\nPossibile admin command:
    help -> this help
    screen -> try to make a screenshot on the bot system
    info -> info on the bot system
    ban [username] -> bot can't reply to username
    unban [username] -> bot can reply to username"
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="admin")
      p "Command received #{cmd}"
      case params[0]
      when "screen"
        uptime=%x[scrot -z tmp/scrot.jpg]
        f=File.open("tmp/scrot.jpg")
        bot.send_photo(chat_id: message.chat.id, photo: f)
      when "info"
        uptime=%x[uptime | awk '{print $3" "$4}']
        uptime=uptime[0..-3]
        p uptime
        kernel=%x[uname -o]
        arch=%x[uname -i]
        m="kernel: #{kernel}arch: #{arch}uptime: #{uptime}"
      when "ban"
      when "unban"
      when "help"
        m=admin_help
      else
        m=admin_help
      end
      
      if m!=nil
        bot.send_message(chat_id: message.chat.id, text: m)
      end
    end
  end

end
