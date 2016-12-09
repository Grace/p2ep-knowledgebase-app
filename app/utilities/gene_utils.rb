module GeneUtils
  def self.create_or_update_gene(number_id, source_id, source, species)
    gene = Gene.find_or_create_by(gene_id: number_id, source_id: source_id, source: source, species: species)
    return gene
  end
end