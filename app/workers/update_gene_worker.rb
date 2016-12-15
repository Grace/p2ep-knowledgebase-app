require 'node'
require 'gene'

class UpdateGeneWorker
  include Sidekiq::Worker
  def perform(data)
    Gene.create_or_update(data)
  end
end