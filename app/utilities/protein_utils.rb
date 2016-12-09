module ProteinUtils
  def self.create_or_update_protein(number_id, source_id, source, species)
    protein = Protein.find_or_create_by(uniprot_id: number_id, source_id: source_id, source: source, species: species)
    return Protein
  end
end