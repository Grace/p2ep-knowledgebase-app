class Pathway < Node
  property :category, type: String, default: 'Pathway'
  property :species, type: String, index: :exact

  # Relationships
  has_many :in, :chemicals, type: :chemicals, model_class: :Chemical, unique: true
  has_many :in, :proteins, type: :proteins, model_class: :Protein, unique: true
  has_many :both, :genes, type: :genes, model_class: :Gene, unique: true
  has_many :out, :diseases, type: :diseases, model_class: :Disease, unique: true
end