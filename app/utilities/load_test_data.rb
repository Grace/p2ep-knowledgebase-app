require_relative '../../config/environment.rb'
require 'yajl'
require 'yajl/json_gem'
require 'active_support/hash_with_indifferent_access'

require 'neo4j'
require 'node'
require 'plant'
require 'chemical'
require 'gene'
require 'disease'
require 'pathway'
require 'neighbor_rel'
require 'gene_utils'
require 'chemical_utils'
require 'disease_utils'
require 'pathway_utils'
require 'protein_utils'
require 'phenotype_utils'


class JSONFileLoader
  def initialize(file)
    @file = file
    @current_directory = File.dirname(__FILE__)
    @absolute_path = File.expand_path @current_directory
  end
end

class JSONLoader < JSONFileLoader
  @filetype = 'json'

  puts '########################### Reading, parsing, and loading data from ' + @file.to_s

  def parse
    json = File.new(@file, 'r')
    parser = Yajl::Parser.new
    hash = parser.parse(json)
    puts hash.keys

    # puts '########################### load chebi -> reactome_at, reactome_hs'
    #   chemicals = hash['chebi']
    #   chemicals.keys.each do |key, value|
    #     # create or update chemical
    #     _source = 'CHEBI'
    #     _source_id = 'CHEBI:' + key.to_s
    #     node = Chemical.find_or_create_by(source_id: _source_id)
    #     node.source = _source
    #     node.save
    #     # create or update child nodes and create connections
    #     children = chemicals[key]
    #     at_pathways_array = children['reactome_at']
    #     hs_pathways_array = children['reactome_hs']
    #     #puts at_pathways_array.inspect
    #     if at_pathways_array
    #       at_pathways_array.each do |identifier|
    #         at_pathway = Pathway.find_or_create_by(name: identifier)
    #         at_pathway.species = 'Arabidopsis thaliana'
    #         at_pathway.source = 'reactome_at'
    #         if at_pathway.save
    #           #c = NeighborRel.new(from_node: node, to_node: at_pathway)
    #           #c.save
    #           node.pathways << at_pathway
    #         end
    #       end
    #     end
    #
    #     if hs_pathways_array
    #       hs_pathways_array.each do |identifier|
    #         hs_pathway = Pathway.find_or_create_by(name: identifier)
    #         hs_pathway.species = 'Homo sapiens'
    #         hs_pathway.source = 'reactome_hs'
    #         if hs_pathway.save
    #           #c = NeighborRel.new(from_node: node, to_node: hs_pathway)
    #           #c.save
    #           node.pathways << hs_pathway
    #         end
    #       end
    #     end
    #   end
    #   puts 'Chemicals and connections from chebi loaded into database'
    #
    #
    # puts '########################### load entrez_gene_at -> uniprot_at'
    #   genes = hash['entrez_gene_at']
    #   genes.keys.each do |key, value|
    #     # create or update gene
    #     _source = 'NCBI_Entrez_Gene'
    #     _source_id = 'ENTREZ:' + key.to_s
    #     gene = Gene.find_or_create_by(source_id: _source_id)
    #     gene.gene_id = key.to_s
    #     gene.source = _source
    #     gene.species = 'Arabidopsis thaliana'
    #     gene.save
    #     # create or update child nodes and create connections
    #     children = genes[key]
    #     uniprot_at_array = children['uniprot_at']
    #     if uniprot_at_array
    #       uniprot_at_array.each do |identifier|
    #         protein = Protein.find_or_create_by(name: identifier)
    #         protein.species = 'Arabidopsis thaliana'
    #         protein.source_id = identifier.to_s
    #         protein.uniprot_id = identifier.to_s
    #         protein.source = 'uniprot_at'
    #         if protein.save
    #           #c = NeighborRel.new(from_node: gene, to_node: protein)
    #           #c.save
    #           gene.proteins << protein
    #         end
    #       end
    #     end
    #   end
    #   puts 'Genes and connections from entrez_gene_at loaded into database'
    #
    #
    # puts '########################### load entrez_gene_hs -> uniprot_hs, gwas, omim_gene'
    #
    #   genes = hash['entrez_gene_hs']
    #   genes.keys.each do |key, value|
    #     # create or update gene
    #     _source = 'NCBI_Entrez_Gene'
    #     _source_id = 'ENTREZ:' + key.to_s
    #     gene = Gene.find_or_create_by(source_id: _source_id)
    #     gene.gene_id = key.to_s
    #     gene.source = _source
    #     gene.species = 'Homo sapiens'
    #     gene.save
    #     # create or update child nodes and create connections
    #     children = genes[key]
    #     # proteins
    #     uniprot_hs_array = children['uniprot_hs']
    #     gwas_array = children['gwas']
    #     omim_gene_array = children['omim_gene']
    #     if uniprot_hs_array
    #       uniprot_hs_array.each do |identifier|
    #         protein = Protein.find_or_create_by(name: identifier)
    #         protein.species = 'Homo sapiens'
    #         protein.source_id = identifier.to_s
    #         protein.uniprot_id = identifier.to_s
    #         protein.source = 'uniprot_hs'
    #         if protein.save
    #           #c = NeighborRel.new(from_node: gene, to_node: protein)
    #           #c.save
    #           gene.proteins << protein
    #         end
    #       end
    #     end
    #
    #     phenotype = nil
    #     if gwas_array
    #       gwas_array.each do |name|
    #         phenotype = Phenotype.find_or_create_by(name: name.to_s.downcase)
    #         if phenotype.save
    #           #c = NeighborRel.new(from_node: gene, to_node: phenotype)
    #           #c.save
    #           gene.phenotypes << phenotype
    #         end
    #       end
    #     end
    #
    #     if omim_gene_array
    #       omim_gene_array.each do |identifier|
    #         omim_source = 'OMIM_Gene'
    #         omim_source_id = 'OMIM_Gene:' + key.to_s
    #         omim_gene = Gene.find_or_create_by(source_id: omim_source_id)
    #         omim_gene.species = 'Homo sapiens'
    #         omim_gene.source = omim_source
    #         omim_gene.phenotypes << phenotype unless phenotype.nil?
    #         if omim_gene.save
    #           #c = NeighborRel.new(from_node: gene, to_node: omim_gene)
    #           #c.save
    #           #gene.genes << omim_gene
    #
    #         end
    #       end
    #     end
    #   end
    #   puts 'Genes and connections from entrez_gene_hs loaded into database'
    #
    # puts '########################### load gwas (phenotypes) -> entrez_gene_hs'
    # nodes = hash['gwas']
    # nodes.keys.each do |key, value|
    #   # create or update gene
    #   node = Phenotype.find_or_create_by(name: key.to_s.downcase)
    #   node.source = 'GWAS'
    #   node.save
    #   # create or update child nodes and create connections
    #   children = nodes[key]
    #   children_array = children['entrez_gene_hs']
    #   if children_array
    #     children_array.each do |identifier|
    #         child_source = 'NCBI_Entrez_Gene'
    #         child_source_id = 'ENTREZ:' + identifier.to_s
    #         gene = Gene.find_or_create_by(source_id: child_source_id)
    #         gene.gene_id = identifier.to_s
    #         gene.source = child_source
    #         gene.species = 'Homo sapiens'
    #         gene.save
    #       if gene.save
    #         #c = NeighborRel.new(from_node: node, to_node: gene)
    #         #c.save
    #         node.genes << gene
    #       end
    #     end
    #   end
    # end
    # puts 'Genes and connections gwas loaded into database'
    #
    #
    # puts '########################### load omim_disease -> omim_gene'
    #
    # categoryA = 'omim_disease'
    # categoryB = 'omim_gene'
    #
    # nodes = hash[categoryA]
    # nodes.keys.each do |key, value|
    #   disease = Disease.find_or_create_by(disease_id: key)
    #   disease.source = 'OMIM_Disease'
    #   disease.species = 'Homo Sapiens'
    #   disease.source_id = 'OMIM_Disease:' + key.to_s
    #   disease.save
    #   # create or update neighbor nodes and create connections
    #   children = nodes[key]
    #   children_array = children[categoryB]
    #   if children_array
    #     children_array.each do |identifier|
    #       neighbor = GeneUtils::create_or_update_gene(identifier, 'OMIM_Gene:' + identifier.to_s, 'OMIM_Gene', 'Homo sapiens')
    #       if neighbor.save
    #         #c = NeighborRel.new(from_node: disease, to_node: neighbor)
    #         #c.save
    #         #disease.genes << neighbor
    #         neighbor.diseases << disease
    #       end
    #     end
    #   end
    # end
    #
    # puts categoryA + ' loaded into database'
    #


    puts '########################### loading omim_gene -> omim_disease, entrez_gene_hs'


    categoryA = 'omim_gene'
    categoryB = 'omim_disease'
    categoryC = 'entrez_gene_hs'

    nodes = hash[categoryA]
    nodes.keys.each do |key, value|
      node = GeneUtils.create_or_update_gene(key, 'OMIM_Gene:' + key.to_s, 'OMIM_Gene', 'Homo sapiens')
      node.save
      # create or update neighbor nodes and create connections
      children = nodes[key]
      children_array = children[categoryB]
      neighborB = nil


      if children_array
        children_array.each do |identifier|
          neighborB = DiseaseUtils::create_or_update_disease(identifier, 'OMIM_Disease:' + identifier.to_s, 'OMIM_Disease', 'Homo sapiens')
          if neighborB.save
            #c = NeighborRel.new(from_node: node, to_node: neighborB)
            #c.save
            node.diseases << neighborB
          end
        end
      end


      children_array = children[categoryC]
      if children_array
        children_array.each do |identifier|
          neighborC = GeneUtils::create_or_update_gene(identifier, 'Entrez_Gene:' + identifier.to_s, 'Entrez_Gene', 'Homo sapiens')
          neighborC.diseases << neighborB unless neighborB.nil?
          if neighborC.save
            #c = NeighborRel.new(from_node: node, to_node: neighborC)
            #c.save
            # node.genes << neighbor
          end
        end
      end
    end

    puts categoryA + ' loaded into database'


  end
end



current_directory = File.dirname(__FILE__)
absolute_path = File.expand_path current_directory

parser = JSONLoader.new(File.join(absolute_path, '/data/jeremy_data.json'))
parser.parse