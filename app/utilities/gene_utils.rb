#!/usr/bin/ruby

require_relative '../../config/environment.rb'
require 'net/http'
require 'uri'
require 'rubygems'
require 'json'
require 'pp'
require 'neo4j'
require 'node'
require 'gene'

module GeneUtils
  def self.create_or_update_gene(number_id, source_id, source, species)
    gene = Gene.find_or_create_by(gene_id: number_id, source_id: source_id, source: source, species: species)
    return gene
  end

  def self.create_entrez_gene(entrez_id, species)
    gene = Gene.find_or_create(entrez_gene_id: entrez_id.to_s, species: species, source_abbreviation: 'ENTREZ', source: 'NCBI Entrez Gene')
  end

  def self.create_omim_gene(omim_id, species)
    gene = Gene.find_or_create(entrez_gene_id: omim_id.to_s, species: species, source_abbreviation: 'OMIM', source: 'OMIM Gene')
  end

  # casts array input to a comma separated string if needed
  def self.a_to_s(input)
    if input.is_a? Array
      return input.join(', ').to_s
    end
    input.to_s unless input.nil?
  end

  def self.create_or_update(g)
    name = g['name'].to_s or nil
    prev_name = GeneUtils.a_to_s(g['prev_name']) or nil
    gene_symbol = g['symbol'].to_s.upcase or nil # Approved Gene Symbol
    hgnc_id = g['hgnc_id'].to_s or nil # HGNC ID
    chromosome_location = g['location'].to_s or nil
    alias_symbols = GeneUtils.a_to_s(g['alias_symbol']) or nil # Alias gene symbols (a.k.a, gene synonyms)
    ensembl_gene_id = g['ensembl_gene_id'].to_s or nil # Ensembl gene ID
    entrez_gene_id = g['entrez_id'].to_s or nil # NCBI gene ID
    uniprot_ids = GeneUtils.a_to_s(g['uniprot_ids']) or nil # UniProt Ids
    omim_id = GeneUtils.a_to_s(g['omim_id']) or nil # OMIM Gene ID
    pubmed_ids = GeneUtils.a_to_s(g['pubmed_id'].to_s) or nil
    gene_family =  GeneUtils.a_to_s(g['gene_family']) or nil
    gene_family_ids = GeneUtils.a_to_s(g['gene_family_id']) or nil
    locus_type = g['locus_type'].to_s or nil
    mgd_id = GeneUtils.a_to_s(g['mgd_id']) or nil
    refseq = GeneUtils.a_to_s(g['refseq_accession']) or nil
    gene = nil
    begin
      gene = Gene.find_or_create_by!(gene_symbol: gene_symbol.to_s.upcase)
    rescue
      gene = Gene.create(gene_symbol: gene_symbol.to_s.upcase)
    end
    if gene
      gene.symbol = gene_symbol.to_s.upcase unless gene_symbol.nil?
      gene.alias_symbols = alias_symbols unless alias_symbols.nil?
      gene.prev_name = prev_name unless prev_name.nil?
      gene.name = name unless prev_name.nil?
      gene.hgnc_id = hgnc_id unless hgnc_id.nil?
      gene.chromosome_location = chromosome_location unless chromosome_location.nil?
      gene.entrez_gene_id = entrez_gene_id unless entrez_gene_id.nil?
      gene.ensembl_gene_id = ensembl_gene_id unless ensembl_gene_id.nil?
      gene.uniprot_ids = uniprot_ids unless uniprot_ids.nil?
      gene.omim_gene_id = omim_id unless omim_id.nil?
      gene.pubmed_ids = pubmed_ids unless pubmed_ids.nil?
      gene.gene_family = gene_family unless gene_family.nil?
      gene.gene_family_ids = gene_family_ids unless gene_family_ids.nil?
      gene.locus_type = locus_type unless locus_type.nil?
      gene.mgd_id = mgd_id unless mgd_id.nil?
      gene.refseq_accession = refseq unless refseq.nil?
    end
    return gene
  end

  def self.fetch_gene_symbol_report(gene_symbol)
    server='http://rest.genenames.org'
    get_path = '/fetch/symbol/' + gene_symbol.to_s.downcase

    url = URI.parse(server)
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(get_path, {'Accept' => 'application/json'})
    response = http.request(request)

    if response.code != "200"
      puts "Invalid response: #{response.code}"
      puts response.body
      exit
    end

    result = JSON.parse(response.body)
    gene_data = result['response']['docs'][0]
  end

end

# gene_data = GeneUtils.fetch_gene_symbol_report('BRAF')
# gene = GeneUtils.create_or_update(gene_data)
#
# entrez_id_number = gene.entrez_gene_id
# omim_id_number = gene.omim_gene_id
#
# entrez_source_id = 'ENTREZ:' + entrez_id_number.to_s
# omim_source_id = 'OMIM_Gene:' + omim_id_number.to_s




