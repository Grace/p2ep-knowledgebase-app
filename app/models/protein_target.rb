class ProteinTarget < Node
  searchkick
  self.mapped_label_name = 'Protein_Target' # Maps this model class to the actual Neo4j label
  property :category, type: String, default: 'Protein Target'
  property :function, type: String, index: :exact
  property :diseases, type: String, index: :exact
  property :wiki_pathway, type: String
  property :kegg_pathway, type: String
end