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
Open the `bin/telegrammer-plugin` file and insert your Bot API token in line 13

(For the Token, talk with the [@BotFather](https://telegram.me/botfather).
Learn more about this [here](https://core.telegram.org/bots))

```
nano bin/telegrammer-plugin
```

## Usage
Start the Bot with `bin/telegrammer-plugin`

```
chmod +x bin/telegrammer-plugin
bin/telegrammer-plugin
```

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

an example:
```ruby
# derive from TelegrammerPlugin
class VersionPlugin < TelegrammerPlugin
  # the handle_command that the bot will call
  def self.handle_command(cmd,params,bot,message)
    # check for the right command
    if(cmd=="version")
      # print in stdin
      p "Command received #{cmd}"
      m="Telegrammer version: #{Telegrammer::VERSION}\nTelegrammerPlugin version: #{TelegrammerPlugin::VERSION}"
      # send message with the bot
      bot.send_message(chat_id: message.chat.id, text: "#{m}")
    end
  end

end

```
