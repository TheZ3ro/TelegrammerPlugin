# TelegrammerPlugin
This is a Telegram Bot made on top of [Telegrammer](https://github.com/mayoral/telegrammer)

Under HEAVY Development

Pull Requests always appreciated

## Installation
##### With git
```
git clone https://github.com/thez3ro/TelegrammerPlugin
cd TelegrammerPlugin
```

## Configuration
Open the `config.yml` file and insert your Bot API token in line 4

(For the Token, talk with the [@BotFather](https://telegram.me/botfather).
Learn more about this [here](https://core.telegram.org/bots))
```yaml
---
bot: "YOUR_BOT_USERNAME"
admin: "YOUR_USERNAME"
admin_code: "0000"
token: "YOUR_TOKEN"
```

## Usage
Start the Bot with `bin/telegrammer-plugin`

```
chmod +x bin/telegrammer-plugin
bin/telegrammer-plugin
```

## Contributing

When you are Contributing to the main fork you should consider do some thing:
* Untrack your config.yml (`git update-index --assume-unchanged config.yml`)
* **When needed** Re-track config.yml changes (`git update-index --no-assume-unchanged config.yml; git add config.yml`)


1. Create your feature branch (`git checkout -b my-new-feature`)
2. Commit your changes (`git commit -am 'Add some feature'`)
3. Push to the branch (`git push origin my-new-feature`)
4. Create a new Pull Request

## Creating new Plugins
The bot load automatically every plugin in the `./plugins` folder.

Every plugin **must** derive from **TelegrammerPlugin**

When a message is received, the bot call `handle_command(cmd,params,bot,message)` function for every plugin, it's up to the plugin to catch the Command
and do the work
The variable type are:

* cmd => [String] : contains the command string
* params => [Array] : the command parameters
* bot => [Telegrammer::Bot] : the Bot (see [telegrammer/bot.rb](https://github.com/mayoral/telegrammer/blob/master/lib/telegrammer/bot.rb) for methods)
* message => [Telegrammer::DataTypes::Message] : the Message Object (see [telegrammer/data_types/message.rb](https://github.com/mayoral/telegrammer/blob/master/lib/telegrammer/data_types/message.rb) for methods)

When the **help** command is called, the bot take the help methods for every plugin and send as response.
Help methods **must** return a [String]

**Some commands are reserved**, so they are not available to plugins:
* help
* version
* admin

If your plugin have to download file, consider download them in the `tmp/` folder,
and delete it after it has been sent.
The folder will be created if not present.

Remember that all the **relative path** are relative to the project folder `telegrammer-plugin`

Please, ***for god sake***, print as little as possibile to the console. Thanks.


#### Plugin example:
```ruby
# derive from TelegrammerPlugin
class PingPlugin < TelegrammerPlugin
  # the help method for help command
  def self.help
    '"/ping": Check if the bot is online'
  end
  # the handle_command that the bot will call
  def self.handle_command(cmd,params,bot,message)
    # check for the right command
    if(cmd=="ping")
      # print in stdin
      p "Command received #{cmd}"
      # send message with the bot
      bot.send_message(chat_id: message.chat.id, text: "pong")
    end
  end
end
```

Other Example:

* [BtcPlugin](https://github.com/TheZ3ro/TelegrammerPlugin/blob/master/plugins/btc.rb) -> for HTTP/S request
* [AdminPlugin](https://github.com/TheZ3ro/TelegrammerPlugin/blob/master/plugins/admin.rb) -> for sending photo
* [EchoPlugin](https://github.com/TheZ3ro/TelegrammerPlugin/blob/master/plugins/echo.rb) -> general purpose
