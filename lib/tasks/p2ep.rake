namespace :p2ep do
  desc "TODO"
  task start_neo4j: :environment do
    puts 'Starting Neo4j server'
    `./db/neo4j/development/bin/neo4j start`
  end

end
