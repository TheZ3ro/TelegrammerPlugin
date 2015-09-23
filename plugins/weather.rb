class WeatherPlugin < TelegrammerPlugin
  require 'net/http'
  require 'openssl'
  require 'json'

  def self.help
    '"/weather <city>": Get city weather'
  end

  def self.weather(city)
    uri = URI.parse("http://api.openweathermap.org/data/2.5/weather?q="+city)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)

    if(data["cod"] == 200)
      message = ""
      message += data["name"]+", "+data["sys"]["country"]+"\n"
      message += data["weather"][0]["main"]+": "+data["weather"][0]["description"]+"\n"
      message += (data["main"]["temp"]-272.150).signif(4).to_s+"°C"
      return message
    else
      return "Error City not found"
    end
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="weather")
      p "Command received #{cmd}"
      if params.length == 1
        m=weather(params[0])
      else
        m="Wrong parameter\n"+help
      end
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
      TelegrammerPlugin.pchat(message.chat.id,m,"")
    end
  end

end

class Float
  def signif(signs)
    Float("%.#{signs}g" % self)
  end
end
