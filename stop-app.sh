#!/usr/bin/env bash

docker-compose down
bundle exec rake neo4j:stop &> /dev/null
kill -9 `cat tmp/pids/server.pid` &> /dev/null