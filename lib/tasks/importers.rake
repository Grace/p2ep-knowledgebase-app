##
# Title: importers.rake
# Author: Grace Christenbery (gchriste@uncc.edu)
# Purpose: Rake tasks to import data into the P2EP Knowledgebase

require 'rubygems'
require 'sidekiq'

namespace :import do
  desc "TODO"
  task chemicals: :environment do
  end

  desc "Load file and create/update genes from files in user-specified directory"
  task genes: :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    sources_path = ARGV[1].to_s

    Dir.glob(sources_path + '/*.json') do |json_file|
      puts 'Importing data from ' + json_file.to_s
      fileContent = File.read(File.join(Rails.root,json_file.to_s))
      fileData = JSON.parse(fileContent).to_hash
      if json_file.include? 'hgnc' # HGNC genes json file
        jsonObjects = fileData['response']['docs']
        jsonObjects.each { |jsonObj| UpdateGeneWorker.perform_async(jsonObj) }
      else
        jsonObjects = fileData
        jsonObjects.each { |jsonObj| UpdateGeneWorker.perform_async(jsonObj) }
      end

    end

    Dir.glob(sources_path + '/*.csv') do |csv_file|
      # do work on files ending in .csv
      #puts 'Importing data from ' + csv_file.to_s
    end

    Dir.glob(sources_path + '/*.txt') do |txt_file|
      # do work on files ending in .txt
      #puts 'Importing data from ' + txt_file.to_s
    end
  end

  desc "TODO"
  task diseases: :environment do
  end

  desc "TODO"
  task pathways: :environment do
  end

end
