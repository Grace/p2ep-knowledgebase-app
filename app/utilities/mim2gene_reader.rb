require_relative '../../config/environment.rb'
require 'json'
require 'neo4j'
require 'node'
require 'gene'
require 'disease'
require '../utilities/gene_utils'


file = './data/mim2gene.txt'
File.readlines(file).each do |line|
  next if line.start_with? '#'
  # Columns:
  # MIM Number
  # MIM Entry Type (see FAQ 1.3 at https://omim.org/help/faq)
  # Entrez Gene ID (NCBI)
  # Approved Gene Symbol (HGNC)
  # Ensembl Gene ID (Ensembl)

  #puts line
  row = line.split(/\t/)
  mim_number = row[0] || nil
  entry_type = row[1] || nil
  entrez_gene_id = row[2] || nil
  approved_gene_symbol = row[3] || nil
  ensembl_gene_symbol = row[4] || nil




end