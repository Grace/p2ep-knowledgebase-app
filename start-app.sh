#!/usr/bin/env bash

mkdir -p $PWD/db/neo4j/development/conf
mkdir -p $PWD/db/neo4j/development/data/graph.db
mkdir -p $PWD/db/elasticsearch

bundle exec rake neo4j:start
rails s
