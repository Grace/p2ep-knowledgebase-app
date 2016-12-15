class Protein < Node
  searchkick
  property :category, type: String, default: 'Protein'
  property :gene_symbol, type: String
  property :source, type: String, default: 'Uniprot'
  property :gene_id, type: String
  property :uniprot_id, type: String
  property :species, type: String

  validates_uniqueness_of :uniprot_id, case_sensitive: false


  has_many :in, :genes, type: :genes, model_class: :Gene, unique: true
  has_many :out, :pathways, type: :pathways, model_class: :Pathway, unique: true
end