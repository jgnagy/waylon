# Waylon

This is a convenience gem for making the installation of [Waylon::Core](https://github.com/jgnagy/waylon-core) easier. As a framework, Waylon is inspired by [Lita](https://www.lita.io/) and should be intuitive for anyone familiar with it. Waylon is built to make creating bots of many different kinds easy, fun, and flexible.

It supports different kinds of sensory inputs (chat platforms, web endpoints, and more), as well as easy to build Skills, built-in and extensible permissions, modern JSON logging, and more.

## Why Call it 'Waylon'?

Waylon just seemed like a good name for a bot. Plus, the gem name was available. That's really all there is to it.

Also, the author of the Waylon framework is a fan of The Simpsons, so it is a bit of a bonus that there is a character on that show called "Waylon Smithers, Jr." that is a faithful assistant to "Mr. Burns". Note that while it is a nice coincidence that Waylon shares its name with "Smithers" from that show, neither this framework nor any code within it is inspired by, related to, associated with, or endorsed by that show. Any similarity is entirely coincidental and unintentional.

## Why Make a New Bot Framework?

As a framework, Waylon was designed with several features in mind:

* Scalability
    * Using a pub-sub model and workers based on a queue, scaling up workers is fast and simple
    * Using a shared cache and shared storage, worker instances are completely stateless
* Support for more than just chat-based features
    * Simple Webhook-based Senses
    * Senses that route based on more than just regex
* Advanced chat-based features
    * Built-in concepts like threaded-replies, reactions, and more
    * Support for complex responses using cards, blocks, etc. (based on the Sense's capabilities)
* Security
    * Storage is automatically encrypted
    * Groups (and permissions) are a first-class concept, though user and group implementations are modular
    * Dedicated inbound server process for webhooks that can be locked down (e.g, read-only and very limited capabilities)

This is all while staying familiar to users of Lita. The goal is to make it simple to build powerful bot features while also making it straightforward to migrate existing ones.

Many of these features would be difficult to port to existing frameworks.

## Getting Started

### Creating Your Own Bot

To create a new bot using the Waylon bot framework, you can install the `waylon` gem:

    $ gem install waylon

Then you can use these Waylon executable to create the basics:

    $ waylon init mybot

This creates a directory in your current working directory called `mybot` and populates it with the files needed to get started.

From there, edit the `plugins.rb` file and add some plugins. Check out [this list](https://github.com/search?q=waylon-*+language%3ARuby+user%3Ajgnagy+language%3ARuby+language%3ARuby&type=Repositories&ref=advsearch&l=Ruby&l=Ruby) to see some options.

### Other Custom Ruby Projects

For something custom, add this line to your application's Gemfile:

```ruby
gem 'waylon'
```

And then execute:

    $ bundle install

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jgnagy/waylon.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
