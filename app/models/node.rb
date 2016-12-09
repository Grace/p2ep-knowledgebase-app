class Node 
  include Neo4j::ActiveNode
  # id_property :uuid, auto: :uuid
  id_property :uuid, auto: :uuid
  property :name, type: String, index: :exact
  property :category, type: String, index: :exact
  property :source, type: String, index: :exact
  property :source_abbreviation, type: String, index: :exact
  property :source_id, type: String, index: :exact
  property :description, type: String, default: ''
  property :definition, type: String, default: ''
  property :synonyms, type: String, default: ''

  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :source_id, case_sensitive: false

  has_many :out, :neighbors, type: 'neighbors', model_class: false

  property :created_at, type: DateTime
  property :updated_at, type: DateTime
end