module ChemicalUtils
  def self.create_or_update_chemical(number_id, source_id, source)
    chemical = Chemical.find_or_create_by(chemical_id: number_id, source_id: source_id, source: source)
    return chemical
  end
end