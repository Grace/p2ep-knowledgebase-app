class Plant < Node
  property :category, type: String, default: 'Plant'
  property :plant_id, type: String, unique: true
  property :term, type: String
  property :preferred_term, type: String
  property :rank, type: String
  property :species, type: String

  # validates_uniqueness_of :term, case_sensitive: false
  has_many :out, :chemicals, type: :chemicals, model_class: :Chemical, unique: true
end