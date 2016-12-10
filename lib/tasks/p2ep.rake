namespace :p2ep do
  desc "Starts local Neo4j server in ./db/neo4j/development/bin"
  task start_neo4j: :environment do
    puts 'Starting Neo4j server'
    `./db/neo4j/development/bin/neo4j start`
  end

  desc "Stops local Neo4j server"
  task stop_neo4j: :environment do
    puts 'Stopping Neo4j server'
    `./db/neo4j/development/bin/neo4j stop`
  end

end
