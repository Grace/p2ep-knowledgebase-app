class Disease < Node
  property :category, type: String, default: 'Disease'
  property :term, type: String
  property :mesh_tree_number, type: String
  property :semantic_type, type: String
  property :species, type: String
  property :disease_id, type: String, unique: true

  # Validation
  validates_uniqueness_of :disease_id, case_sensitive: false
  validates_uniqueness_of :term, case_sensitive: false

  has_many :out, :phenotypes, type: :phenotypes, model_class: :Phenotype, unique: true
  has_many :in, :genes, type: :genes, model_class: :Gene, unique: true
end
