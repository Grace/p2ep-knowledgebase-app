class DashboardController < ApplicationController
  def index
    @env = Rails.env
    gon.global.env = @env
    if @env == 'development'
      @neo4jUrl = 'http://localhost:7474'
    elsif @env == 'test'
      @neo4jUrl = 'http://localhost:7575'
    else
      @neo4jUrl = 'http://localhost:7474'
    end

    gon.global.neo4jUrl = @neo4jUrl
    @commitUrl = @neo4jUrl + '/db/data/transaction/commit'
    gon.global.neo4jCommitUrl = @commitUrl

    # Hypothetical search results
    @results = Gene.limit(10).where(species: 'Arabidopsis thaliana')
  end

  def env
    @env = Rails.env
  end

  def neo4jUrl
    @neo4jUrl
  end

  def neo4jCommitUrl
      @neo4jUrl + '/db/data/transaction/commit'
  end

  def search
     query = search_params[:q]
     puts query
  end

  def search_params
    params.permit(:q)
  end
end
