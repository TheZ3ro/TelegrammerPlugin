# TelegrammerPlugin
This is a Telegram Bot made on top of [Telegrammer](https://github.com/mayoral/telegrammer)

Under HEAVY Development

Pull Requests always appreciated

## Installation
#### Installing ruby
Read this guide on [Ruby-lang.org](https://www.ruby-lang.org/en/documentation/installation/)

##### With git
```
git clone https://github.com/thez3ro/TelegrammerPlugin
cd TelegrammerPlugin
```

##### Without git
```
wget -O TelegrammerPlugin.tar.gz https://github.com/TheZ3ro/TelegrammerPlugin/archive/v0.1-beta.0.tar.gz
tar xzf TelegrammerPlugin.tar.gz
cd TelegrammerPlugin-0.1-beta.0
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

See the wiki page about [Contributing](https://github.com/TheZ3ro/TelegrammerPlugin/wiki/Contribute)


## Creating new Plugins

See the wiki page [Creating new Plugin](https://github.com/TheZ3ro/TelegrammerPlugin/wiki/Creating-new-Plugin)
