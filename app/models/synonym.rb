class Synonym 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps
  property :synonym_name, type: String, index: :exact
  property :label, type: String

  has_one in: :node, type: :node, model_class: Node
end
