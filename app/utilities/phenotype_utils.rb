module PhenotypeUtils
  def self.create_or_update_phenotype(name, source_id, source, species)
    phenotype = Phenotype.find_or_create_by(name: name.to_s.downcase, source_id: source_id, source: source, species: species)
    return phenotype
  end
end