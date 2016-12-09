module PathwayUtils
  def self.create_or_update_pathway(number_id, source_id, source, species)
    pathway = Pathway.find_or_create_by(pathway_id: number_id, source_id: source_id, source: source, species: species)
    return pathway
  end
end