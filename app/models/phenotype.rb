class Phenotype < Node
  searchkick
  property :category, type: String, default: 'Phenotype'
  property :species, type: String
  property :phenotype_id, type: String

  has_many :in, :genes, type: :genes, model_class: :Gene, unique: true
end
