class XKCDPlugin < TelegrammerPlugin
  require 'net/http'
  require 'openssl'
  require 'json'

  def self.help
    '"/xkcd <[last]|[random]>": Get xkcd last or random'
  end

  def self.xkcd(path)
    uri = URI.parse("http://xkcd.com/"+path)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)

    return data["num"], data["img"]
  end

  def self.download(img)
    name=img.split('/').last
    Net::HTTP.start("imgs.xkcd.com") do |http|
      f = File.open(File.join(TelegrammerPlugin::TMP,name),"wb")
      begin
          http.request_get("/comics/"+name) do |resp|
              resp.read_body do |segment|
                  f.write(segment)
              end
          end
      ensure
          f.close()
      end
    end
    return File.join(TelegrammerPlugin::TMP,name)
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="xkcd")
      p "Command received #{cmd}"
      if params.length == 1
        if params[0] == "last"
          num,img = xkcd("info.0.json")
        else params[0] == "random"
          num,img = xkcd("info.0.json")
          num,img = xkcd((1 + Random.rand(num)).to_s+"/info.0.json")
        end
        path=download(img)
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
        m="Wrong parameter\n"+help
      end
    end
  end

end
