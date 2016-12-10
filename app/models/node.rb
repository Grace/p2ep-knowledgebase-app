class Node 
  include Neo4j::ActiveNode
  id_property :uuid, auto: :uuid
  property :name, type: String, index: :exact
  property :category, type: String, index: :exact
  property :description, type: String, default: ''
  property :definition, type: String, default: ''
  property :source_abbreviation, type: String, index: :exact
  property :source, type: String, index: :exact
  property :source_id, type: String, index: :exact
  property :sources
  property :source_ids
  property :synonyms, type: String, default: ''
  property :citations, type: String
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :category, case_sensitive: false
  # validates_uniqueness_of :source_id, case_sensitive: false

  # has_many :out, :neighbors, type: 'neighbors', model_class: self
  [[:both, :followers], [:out, :following], [:in, :followed_by]].each do |dir, assoc|
    has_many dir, assoc, type: :following, model_class: self
  end
end