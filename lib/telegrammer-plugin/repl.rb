class TelegrammerRepl
  # Set of conversation
  @conversation = Set.new

  def self.conversation
    @conversation
  end

  def self.repl(bot)
    loop do
      s = gets.chomp
      param = s.split(" ")
      cmd = param.slice!(0)
      case cmd
      when "/list"
        puts @conversation.to_a.join(" | ".red)
      when "/send"
        if param.length>=2
          if param[0].is_num?
            chat_id=param[0].to_i
            param.slice!(0)
            bot.send_message(chat_id: chat_id, text: param.join(" "))
            TelegrammerPlugin.pchat(chat_id,param.join(" "),"")
          else
            puts "Error:".red+" Second parameter must be a chat_id"
          end
        else
          puts "Error:".red+" Not enought parameter (/send [chat_id] [text...])"
        end
      when "/sendp"
        if param.length==2
          if param[0].is_num?
            chat_id=param[0].to_i
            require "open-uri"
            path = File.join(TelegrammerPlugin::TMP,'img.png')
            File.open(path,'wb'){ |fo|
              fo.write open(param[1]).read
            }
            if File.exist?(path)
              File.open(path,'rb'){ |f|
                bot.send_photo(chat_id: chat_id, photo: f)
                TelegrammerPlugin.pchat(chat_id,"*photo*","")
              }
              File.delete(path)
            else
              puts "Error:".red+" File not exist #{path}"
            end
          else
            puts "Error:".red+" Second parameter must be a chat_id"
          end
        else
          puts "Error:".red+" Not enought parameter (/sendp [chat_id] [image_url])"
        end
      when "/end"
        puts "Shutting down...".red
        Kernel.exit!
      when "/exit"
        puts "Shutting down...".red
        Kernel.exit!
      else
        puts "Error:".red+" Invalid command: You entered #{s}"
      end
    end
  end
end
