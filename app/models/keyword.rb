class Keyword 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  id_property :uuid, auto: :uuid
  property :title, type: String, index: :exact

  has_many :in, :publications, type: :publications, model_class: :Publication, unique: true
end
