class Author 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  id_property :uuid, auto: :uuid
  property :first_name, type: String, index: :exact
  property :last_name, type: String, index: :exact

  has_many :out, :publications, type: :publications, model_class: :Publication, unique: true
end
