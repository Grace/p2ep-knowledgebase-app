module DiseaseUtils
  def self.create_or_update_disease(number_id, source_id, source, species)
    disease = Disease.find_or_create_by(disease_id: number_id, source_id: source_id, source: source, species: species)
    return disease
  end
end