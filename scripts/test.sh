#!/bin/sh

apt-get update && apt-get install -y libsodium-dev

gem install bundler -v '~> 2.4'
bundle install
bundle exec rake
