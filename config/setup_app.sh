#!/bin/bash

sleep 3

echo 'Runing configure...'

bundle install
yarn install
rails db:migrate

echo 'Starting server '

rails s -b 0.0.0.0 -p 3000