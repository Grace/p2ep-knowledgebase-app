class PhenotypesController < ApplicationController
  before_action :set_phenotype, only: [:show, :edit, :update, :destroy]

  # GET /phenotypes
  # GET /phenotypes.json
  def index
    @phenotypes = Phenotype.all
  end

  # GET /phenotypes/1
  # GET /phenotypes/1.json
  def show
  end

  # GET /phenotypes/new
  def new
    @phenotype = Phenotype.new
  end

  # GET /phenotypes/1/edit
  def edit
  end

  # POST /phenotypes
  # POST /phenotypes.json
  def create
    @phenotype = Phenotype.new(phenotype_params)

    respond_to do |format|
      if @phenotype.save
        format.html { redirect_to @phenotype, notice: 'Phenotype was successfully created.' }
        format.json { render :show, status: :created, location: @phenotype }
      else
        format.html { render :new }
        format.json { render json: @phenotype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phenotypes/1
  # PATCH/PUT /phenotypes/1.json
  def update
    respond_to do |format|
      if @phenotype.update(phenotype_params)
        format.html { redirect_to @phenotype, notice: 'Phenotype was successfully updated.' }
        format.json { render :show, status: :ok, location: @phenotype }
      else
        format.html { render :edit }
        format.json { render json: @phenotype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phenotypes/1
  # DELETE /phenotypes/1.json
  def destroy
    @phenotype.destroy
    respond_to do |format|
      format.html { redirect_to phenotypes_url, notice: 'Phenotype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phenotype
      @phenotype = Phenotype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phenotype_params
      params.fetch(:phenotype, {})
    end
end
