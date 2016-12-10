class Gene < Node
  property :category, type: String, default: 'Gene'
  property :gene_symbol, type: String, unique: true
  property :alias_symbols, type: String
  property :prev_name, type: String
  property :species, type: String
  property :gene_family, type: String, default: ''

  property :gene_family_ids, type: String
  property :chromosome_location, type: String, default: ''
  property :chromosome, type: Integer
  property :chromosome_start, type: Integer
  property :chromosome_end, type: Integer
  property :omim_gene_id, type: String # Omim ID
  property :entrez_gene_id, type: String # NCBI ID
  property :ensembl_gene_id, type: String # Ensembl Gene ID
  property :uniprot_ids, type: String, default: '' # UniProt IDs
  property :hgnc_id, type: String # HGNC ID
  property :locus_type, type: String
  property :ccds_id, type: String # CCDS ID
  property :pubmed_ids, type: String # PubMed IDs
  property :mgd_id, type: String
  property :refseq_accession, type: String


  # Validation
  validates_uniqueness_of :gene_symbol, case_sensitive: false

  has_many :in, :chemicals, type: :neighbors, model_class: :Chemical, unique: true
  has_many :out, :phenotypes, type: :genes, model_class: self, unique: true
  has_many :out, :diseases, type: :diseases, model_class: :Disease, unique: true
  has_many :out, :proteins, type: :proteins, model_class: :Protein, unique: true
  has_many :out, :pathways, type: :pathways, model_class: :Pathway, unique: true
  has_many :out, :phenotypes, type: :phenotypes, model_class: :Phenotype, unique: true
  has_many :out, :genes, type: :genes, model_class: self, unique: true
end