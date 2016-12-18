class MedicalSubjectHeading < Node
  self.mapped_label_name = 'Medical_Heading' # Maps this model class to the actual Neo4j label

  property :category, type: String, default: 'Medical Subject Heading'
  property :term, type: String
  property :mesh_tree_number, type: String
  property :semantic_type, type: String
  property :species, type: String
  property :omim_disease_id, type: String
  property :disease_id, type: String
  property :medical_heading_id, type: String

  # Relationship Types
  has_many :out, :phenotypes, type: :phenotypes, model_class: :Phenotype, unique: true
  has_many :in, :genes, type: :genes, model_class: :Gene, unique: true
end
