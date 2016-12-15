class Chemical < Node
  searchkick
  # Properties
  property :category, type: String, default: 'Chemical'
  property :chemical_id, type: String, unique: true
  property :preferred_term, type: String

  # Validation
  validates_uniqueness_of :chemical_id, case_sensitive: false

  # Relationships
  has_many :in, :plants, type: :plants, model_class: :Plant, unique: true
  has_many :out, :genes, type: :genes, model_class: :Gene, unique: true
  has_many :out, :pathways, type: :pathways, model_class: :Pathway, unique: true
end