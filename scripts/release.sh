#!/bin/sh

gem install bundler -v '~> 2.4'
bundle install
rm -rf pkg/*.gem
bundle exec rake build
bundle exec gem push pkg/*.gem
