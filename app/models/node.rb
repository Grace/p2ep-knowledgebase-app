class Node 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps # will give model created_at and updated_at timestamps

  id_property :app_id, auto: :app_id
  property :knowledgebase_id, type: String, index: :exact, unique: true # Ex: "ENTREZ:1234567"
  property :name, type: String, index: :exact
  property :label, type: String

  property :node_id, type: String
  property :node_name, type: String
  property :node_type, type: String
  property :node_color, type: String

  property :category, type: String, default: ''
  property :description, type: String, default: '', index: :exact
  property :definition, type: String, default: '', index: :exact

  property :source_abbreviation, type: String, index: :exact
  property :source, type: String, index: :exact
  property :source_id, type: String, index: :exact
  # property :synonym_list, type: String, default: '', index: :exact
  # property :publication_list, type: String, index: :exact

  # Check if a node exists, if not create it. Needs P2EP identifier as parameter (e.g., "GO:1234")
  def create_or_update_by_identifier(knowledgebase_id)
    node = Node.find_or_create_by(knowledgebase_id: knowledgebase_id.to_s)
    node.save!
  end

  has_many :out, :datasources, type: :datasources, model_class: :Datasource, unique: true
  has_many :out, :keywords, type: :keywords, model_class: :Keyword, unique: true
  has_many :out, :synonyms, type: :synonyms, model_class: :Synonym, unique: true
  has_many :out, :publications, type: :publications, model_class: :Publication, unique: true
  validates_uniqueness_of :identifier, case_sensitive: false

  # has_many :out, :neighbors, type: 'neighbors', model_class: self
  # [[:both, :followers], [:out, :following], [:in, :followed_by]].each do |dir, assoc|
  #   has_many dir, assoc, type: :following, model_class: self
  # end
end