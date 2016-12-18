#!/usr/bin/env bash

# Warn the user, require user input to continue
echo "Are you sure you want to reset the local database (this wipes all nodes, relationships, and user accounts)?"
read -p "Enter [y/N]: " answer
if [[ $answer =~ ^y ]]; then
    echo "Resetting local neo4j db..."
    # Completely deletes neo4j database and creates an empty graph.db directory in its place
    rm -rf ./db/neo4j/development/data/databases/graph.db
    mkdir ./db/neo4j/development/data/databases/graph.db
    if [[ "$(docker ps -qf name=neo*)" ]]; then
      container_id="$(docker ps -qf name=neo*)"
      docker exec -t "$container_id" rm -rf /var/lib/neo4j/data/databases/graph.db
      docker exec -t "$container_id" mkdir /var/lib/neo4j/data/databases/graph.db
    fi
    echo "Ok, neo4j db reset!"
fi


