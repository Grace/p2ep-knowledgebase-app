require_relative '../../config/environment.rb'
require 'csv'
require 'json'
require 'neo4j'
require 'node'
require 'plant'
require 'gene_utils'

class FileLoader
  def initialize(filepath)
    @filepath = filepath
    @fileContent = File.read(filepath)
  end
end

class GeneLoader < FileLoader
  @filetype = 'json'
  def parse
    fileData = JSON.parse(@fileContent).to_hash
    data = fileData['response']['docs']
    puts '> Creating/updating Genes from file... This may take a few minutes.'
    data.each do |datum|
      gene = GeneUtils::create_or_update(datum)
      gene.save!
    end
      puts '> Genes created/updated from file.'
  end
end


parser = GeneLoader.new(File.join(Rails.root, '/data/sources/genes/hgnc_complete_set.json'))
parser.parse