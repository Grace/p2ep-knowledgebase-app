class Plant < Node
  searchkick
  property :category, type: String, default: 'Plant', index: :exact
  property :term, type: String, index: :exact
  property :preferred_term, type: String, index: :exact
  property :rank, type: String
  property :species, type: String, index: :exact
  property :plant_id, type:String
  property :medline_id, type:String

  # validates_uniqueness_of :term, case_sensitive: false
  has_many :out, :chemicals, type: :chemicals, model_class: :Chemical, unique: true
end