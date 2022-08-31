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

### Creating A New Skill

Waylon's abilities, usually for responding to input (things like replying to a chat message or responding to a webhook) are packaged in plugins called `Skills`. These Skills use what are called `Routes` to determine what to do with input (and whether or not input can be handled by a particular Skill).

In most cases, a route needs to be defined that matches some text. Waylon supports [Regular Expressions](https://www.rubyguides.com/2015/06/ruby-regex/) to perform this matching, though other forms of `Conditions` can easily be implemented (we'll save that for another time).

Finally, we'll need to define an _action_ that is performed when input matches a Route. This is usually just a standard method in Ruby.

Let's start with a very basic example. We can create a Skill that allows Waylon to perform simple a simple "echo" function, meaning Waylon will just reply with whatever we tell him to.

Install the `waylon` gem:

    $ gem install waylon

Then, create a new skill gem:

    $ waylon skill echo

This will create a gem for you in a directory called `waylon-echo`. You'll need to edit `waylon-echo/waylon-echo.gemspec` and fill in a few important details.

First, find any line containing `TODO` and fill in actual values. Remove `spec.metadata["allowed_push_host"]` unless you have your own private gem server. Remove any other `spec.metadata` lines you don't need.

Toward the end of the file (but before the final `end`), add a line like this:

    spec.add_dependency "waylon-core", "~> 0.2"

You'll also need to add a few development dependencies:

    spec.add_development_dependency "pry"
    spec.add_development_dependency "rubocop"
    spec.add_development_dependency "yard"

Now install all the dependencies:

    bundle install

Now you should be able to start development. Take a look at `lib/waylon/skills/echo.rb`. Delete the `route()` at the beginning of the file and replace it with this:

    route(/^say\s+(.+)/, :do_the_thing)

This simple route will look for text beginning with "say" and capture any words after it. This captured content will be available in `tokens[0]` (or `tokens.last`).

Now, we can use this to respond. Edit the `do_the_thing` method so it looks like this:

    def do_the_thing
      react :speech_balloon
    
      reply "echo: #{tokens.last}"
    end

That's it! Save the file and now you have an echo plugin. You can even demo it with:

    $ bundle exec rake demo

You'll be presented with a REPL interface. You can type `say something` and you should get a response back from Waylon that looks something like this:

    (@homer) << say something
    (@waylon) >> :speech_balloon:
    echo: 'something'

From here, you'll want to do all the typical ruby things like writing tests, updating the README.md, etc., but that's the easy stuff.

To actually use this with a real chat platform, you'll need to build and release your new gem. This is beyond the scope of this short guide, but [RubyGems.org](https://rubygems.org/) has a great [guide for publishing a gem](https://guides.rubygems.org/publishing/) that is worth reading.

After you've published your gem, you can use it in your own bot. Keep reading to see how that works!
### Creating Your Own Bot

To create a new bot using the Waylon bot framework, you can install the `waylon` gem:

    $ gem install waylon

Then you can use these Waylon executable to create the basics:

    $ waylon init mybot

This creates a directory in your current working directory called `mybot` and populates it with the files needed to get started.

From there, edit the `plugins.rb` file and add some plugins. Check out [this list](https://github.com/search?q=waylon-*+language%3ARuby+user%3Ajgnagy+language%3ARuby+language%3ARuby&type=Repositories&ref=advsearch&l=Ruby&l=Ruby) to see some options.

### Building a Docker Image

Assuming you used `waylon init` from above, you'll have a `Dockerfile` in your repo ready to go. In most cases, you just need to use `docker build -t waylon .` to build an image that can be used in a container environment (such as Kubernetes). You'll likely need to push this to a registry. Waylon and its open-source plugins should never cause sensitive information to be embedded within your image, but if you're using proprietary plugins, you'll want to avoid pushing your built image to a public registry.

For examples on how to deploy your Waylon image to Kubernetes, see the [`helm` example](examples/deploying/helm/waylon/) or the [pure Kubernetes example](examples/deploying/k8s/).

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
