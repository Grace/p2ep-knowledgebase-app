require_relative '../../config/environment.rb'
require 'csv'
require 'json'
require 'active_support/hash_with_indifferent_access'
require 'neo4j'
require 'node'
require 'plant'

class CaseInsensitiveHash < HashWithIndifferentAccess
  # This method shouldn't need an override, but my tests say otherwise.
  def [](key)
    super convert_key(key)
  end

  protected

  def convert_key(key)
    key.respond_to?(:downcase) ? key.downcase : key
  end
end


class PlantFileLoader
  def initialize(file)
    @file = file
    @current_directory = File.dirname(__FILE__)
    @absolute_path = File.expand_path @current_directory
  end
end

class PlantCSVLoader < PlantFileLoader
  @filetype = 'csv'

  def parse
    CSV.foreach(@file, :headers => false) do |row|
      #data = CaseInsensitiveHash.new(Hash(JSON.parse(row[0])))
      new_hash = {}
      data = JSON.parse(row[0]).to_hash
      #puts data
      data.to_hash.each_pair do |k,v|
        new_hash.merge!({k.downcase => v})
      end
      puts new_hash
      _name = new_hash['name'] || ''
      puts _name
      _definition = new_hash['definition'] || nil
      _source = new_hash['source'] || nil
      _source_id = new_hash['source_id'] || nil
      _synonyms = new_hash['synonyms'].to_a
      puts _synonyms.join(', ')
      plant = Plant.find_or_create_by(name: _name)
      plant.term = _name
      plant.preferred_term = _name
      plant.definition = _definition.to_s
      plant.source = _source.to_s
      plant.source_abbreviation = 'PO'
      plant.source_id = _source_id.to_s
      plant.synonyms = _synonyms.join(', ')
      plant.save
    end
  end

end

current_directory = File.dirname(__FILE__)
absolute_path = File.expand_path current_directory

parser = PlantCSVLoader.new(File.join(absolute_path, '/data/test_plant_data.csv'))
parser.parse