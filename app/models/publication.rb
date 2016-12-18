class Publication 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  id_property :uuid, auto: :uuid
  property :title, type: String, index: :exact
  property :date, type: String, index: :exact

  has_many :in, :nodes, type: :nodes, model_class: :Node, unique: true
  has_many :in, :authors, type: :authors, model_class: :Author, unique: true
  has_many :out, :keywords, type: :keywords, model_class: :Keyword, unique: true
end
