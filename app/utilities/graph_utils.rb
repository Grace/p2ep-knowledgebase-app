# MATCH path1 = shortestPath( (plant:Plant {Term: "Vaccinium corymbosum"})-[*..5]-(gene:Gene {Description: "adenylate cyclase activating polypeptide 1"}) )
# MATCH path2 = shortestPath( (gene)-[*..5]-(disease:Medical_Heading {Term: "Alzheimer Disease"}) )
# RETURN path1, path2



def shortestPathFromPlantToDisease(plant_name, disease_name)
  query = Neo4j::Session.query.match("(plant:Plant),(disease:Disease), p = shortestPath((plant)-[*..15]-(disease))").where(plant: { name: plant_name.to_s }).where(disease: { name: disease_name.to_s }).return(:p)
  query.inspect
end
