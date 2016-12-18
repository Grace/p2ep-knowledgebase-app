class Datasource 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  id_property :uuid, auto: :uuid
  property :name, type: String, index: :exact # Example: NCBI Entrez Gene Database
  property :abbreviation, type: String, index: :exact # Example: ENTREZ
  property :underscore_notation, type: String, index: :exact # Example: NCBI_Entrez_Gene
  has_many :in, :nodes, type: :nodes, model_class: :Node, unique:true
end
