class Gene < Node
  searchkick
  property :category, type: String, default: 'Gene', index: :exact
  property :gene_symbol, type: String, index: :exact
  property :alias_symbols, type: String, index: :exact
  property :prev_name, type: String, index: :exact
  property :species, type: String, index: :exact
  property :chromosome_location, type: String, default: ''
  property :chromosome, type: Integer
  property :chromosome_start, type: Integer
  property :chromosome_end, type: Integer
  property :gene_family, type: String, default: ''
  property :gene_family_ids, type: String
  property :gene_id, type: String
  property :omim_gene_id, type: String, index: :exact # Omim ID
  property :entrez_gene_id, type: String, index: :exact # NCBI ID
  property :go_id, type: String, index: :exact # GO ID
  property :ensembl_gene_id, type: String, index: :exact # Ensembl Gene ID
  property :uniprot_ids, type: String, default: '' # UniProt IDs
  property :hgnc_id, type: String, index: :exact # HGNC ID
  property :locus_type, type: String, index: :exact
  property :ccds_id, type: String # CCDS ID
  property :pubmed_ids, type: String # PubMed IDs
  property :mgd_id, type: String
  property :refseq_accession, type: String


  # Validation
  validates_uniqueness_of :gene_symbol, case_sensitive: false

  has_many :in, :chemicals, type: :chemicals, model_class: :Chemical, unique: true
  has_many :out, :diseases, type: :diseases, model_class: :Disease, unique: true
  has_many :out, :proteins, type: :proteins, model_class: :Protein, unique: true
  has_many :out, :pathways, type: :pathways, model_class: :Pathway, unique: true
  has_many :out, :phenotypes, type: :phenotypes, model_class: :Phenotype, unique: true
  has_many :out, :genes, type: :genes, model_class: self, unique: true

  def self.create_or_update(data)
    name = data['name'].to_s or nil
    prev_name = GeneUtils.a_to_s(data['prev_name']) or nil
    gene_symbol = data['symbol'].to_s.upcase or nil # Approved Gene Symbol
    hgnc_id = data['hgnc_id'].to_s or nil # HGNC ID
    chromosome_location = data['location'].to_s or nil
    alias_symbols = GeneUtils.a_to_s(data['alias_symbol']) or nil # Alias gene symbols (a.k.a, gene synonyms)
    ensembl_gene_id = data['ensembl_gene_id'].to_s or nil # Ensembl gene ID
    entrez_gene_id = data['entrez_id'].to_s or nil # NCBI gene ID
    uniprot_ids = GeneUtils.a_to_s(data['uniprot_ids']) or nil # UniProt Ids
    omim_id = GeneUtils.a_to_s(data['omim_id']) or nil # OMIM Gene ID
    pubmed_ids = GeneUtils.a_to_s(data['pubmed_id'].to_s) or nil
    gene_family =  GeneUtils.a_to_s(data['gene_family']) or nil
    gene_family_ids = GeneUtils.a_to_s(data['gene_family_id']) or nil
    locus_type = data['locus_type'].to_s or nil
    mgd_id = GeneUtils.a_to_s(data['mgd_id']) or nil
    refseq = GeneUtils.a_to_s(data['refseq_accession']) or nil
    gene = nil
    begin
      gene = Gene.find_or_create_by!(gene_symbol: gene_symbol.to_s.upcase)
    rescue
      gene = Gene.create!(gene_symbol: gene_symbol.to_s.upcase)
    end
    if gene
      gene.symbol = gene_symbol.to_s.upcase unless gene_symbol.nil?
      gene.alias_symbols = alias_symbols unless alias_symbols.nil?
      gene.prev_name = prev_name unless prev_name.nil?
      gene.name = name unless prev_name.nil?
      gene.hgnc_id = hgnc_id unless hgnc_id.nil?
      gene.chromosome_location = chromosome_location unless chromosome_location.nil?
      gene.entrez_gene_id = entrez_gene_id unless entrez_gene_id.nil?
      gene.ensembl_gene_id = ensembl_gene_id unless ensembl_gene_id.nil?
      gene.uniprot_ids = uniprot_ids unless uniprot_ids.nil?
      gene.omim_gene_id = omim_id unless omim_id.nil?
      gene.pubmed_ids = pubmed_ids unless pubmed_ids.nil?
      gene.gene_family = gene_family unless gene_family.nil?
      gene.gene_family_ids = gene_family_ids unless gene_family_ids.nil?
      gene.locus_type = locus_type unless locus_type.nil?
      gene.mgd_id = mgd_id unless mgd_id.nil?
      gene.refseq_accession = refseq unless refseq.nil?
    end
    return gene if gene.save!
  end
end