class Node 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps

  id_property :uuid, auto: :uuid
  property :name, type: String, index: :exact
  property :symbol, type: String, index: :exact
  property :term, type: String, index: :exact
  property :label, type: String
  property :keywords, type: String
  property :category, type: String, index: :exact
  property :description, type: String, default: ''
  property :definition, type: String, default: ''
  property :source_abbreviation, type: String, index: :exact
  property :source, type: String, index: :exact
  property :source_id, type: String, index: :exact
  property :source_ids, index: :exact
  property :sources, index: :exact
  property :synonyms, type: String, default: '', index: :exact
  property :citations, type: String
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  # validates_uniqueness_of :name, case_sensitive: false
  # validates_uniqueness_of :category, case_sensitive: false
  # validates_uniqueness_of :source_id, case_sensitive: false

  # has_many :out, :neighbors, type: 'neighbors', model_class: self
  # [[:both, :followers], [:out, :following], [:in, :followed_by]].each do |dir, assoc|
  #   has_many dir, assoc, type: :following, model_class: self
  # end
end