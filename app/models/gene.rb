class Gene < Node
  property :category, type: String, default: 'Gene'
  property :gene_id, type: String, unique: true
  property :preferred_term, type: String
  property :gene_symbol, type: String
  property :species, type: String

  # Validation
  validates_uniqueness_of :gene_id, case_sensitive: false
  validates_uniqueness_of :gene_symbol, case_sensitive: false

  has_many :in, :chemicals, type: :neighbors, model_class: :Chemical, unique: true
  has_many :out, :phenotypes, type: :genes, model_class: self, unique: true
  has_many :out, :diseases, type: :diseases, model_class: :Disease, unique: true
  has_many :out, :proteins, type: :proteins, model_class: :Protein, unique: true
  has_many :out, :pathways, type: :pathways, model_class: :Pathway, unique: true
  has_many :out, :phenotypes, type: :phenotypes, model_class: :Phenotype, unique: true
end