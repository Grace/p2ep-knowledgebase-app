module DiseaseUtils
  def self.create_or_update_disease(number_id, source_id, source, species)
    disease = Disease.find_or_create_by(disease_id: number_id, source_id: source_id, source: source, species: species)
    return disease
  end

  def self.create_omim_disease(omim_id)
    disease = Disease.find_or_create(omim_disease_id: omim_id.to_s, species: 'Homo Sapiens', source_abbreviation: 'OMIM', source: 'OMIM Disease')
  end

end