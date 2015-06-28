class AdminPlugin < TelegrammerPlugin

  def self.help
    '"/admin <admin_command> <admin_code>": a Root set of command '
  end

  def self.admin_help
    help+"\n\nPossibile admin command:
    help -> this help
    screen -> try to make a screenshot on the bot system
    cam -> try to make a webcam shot
    info -> info on the bot system
    ban [username] -> bot can't reply to username
    unban [username] -> bot can reply to username"
  end

  def self.json_to_array(pa)
    b=[]
    if File.exist?(pa)
      File.open(pa,'r'){ |f|
        b=MultiJson.decode(f)
      }
    end
    return b
  end

  def self.array_to_json(pa,b)
    File.open(pa,'w'){ |f2|
      f2.puts MultiJson.encode(b)
    }
  end

  def self.is_banned?(u)
    path=File.join(TelegrammerPlugin::TMP,"ban.json")
    ban=json_to_array(path)
    ban.include? u
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="admin")
      p "Command received #{cmd}"
      case params[0]
      when "screen"
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
      when "cam"
        path = File.join(TelegrammerPlugin::TMP,"web-cam-shot.jpg")
        tmp=%x[fswebcam -r 640x480 --jpeg 85 -D 1 #{path}]
        if File.exist?(path)
          File.open(path){ |f|
            bot.send_photo(chat_id: message.chat.id, photo: f)
          }
          File.delete(path)
        else
          puts "Error:".red+" File not exist #{path}"
        end
      when "info"
        uptime=%x[uptime | awk '{print $3" "$4}']
        uptime=uptime[0..-3]
        kernel=%x[uname -o]
        arch=%x[uname -i]
        m="kernel: #{kernel}arch: #{arch}uptime: #{uptime}"
      when "ban"
        if params[1] != ""
          path = File.join(TelegrammerPlugin::TMP,"ban.json")
          ban=json_to_array(path)
          ban<<params[1]
          array_to_json(path,ban)
          m="Banned #{params[1]}"
        end
      when "unban"
        if params[1] != ""
          path = File.join(TelegrammerPlugin::TMP,"ban.json")
          ban=json_to_array(path)
          i=ban.index(params[1])
          if i!=nil
            ban.delete_at(i)
            array_to_json(path,ban)
            m="Unbanned #{params[1]}"
          else
            m="#{params[1]} is not banned"
          end
        end
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
