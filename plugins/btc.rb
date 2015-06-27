class BtcPlugin < TelegrammerPlugin
  require 'net/http'
  require 'openssl'
  require 'json'

  def self.help
    '"/btc <currency>": Print BTC price in currency (USD/EUR)'
  end

  def self.btc(currency)
    currency.upcase!
    p currency
    if currency == "USD"
      path="2/btc_usd/ticker"
    elsif currency == "EUR"
      path="2/btc_eur/ticker"
    else
      return nil
    end
    uri = URI.parse("https://btc-e.com/api/"+path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)

    usd = data["ticker"]["last"]
    return usd.to_s
  end

  def self.handle_command(cmd,params,bot,message)
    if(cmd=="btc")
      p "Command received #{cmd}"
      if params.length == 1
        val=btc(params[0])
        if val == nil
          m="Error Btc-e API"
        else
          m="1 BTC = #{val} #{params[0]}"
        end
      else
        m="Wrong parameter\n"+help
      end
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
    end
  end

end
