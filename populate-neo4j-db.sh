#!/bin/bash

IFS=$'\n'
set -eu
#set -x

NEO4J_ROOT="db/neo4j"
DATA="data/neo4j-imports/outfiles"

# Remove any previous database version to prepare for import into Neo4j
#rm -r ${NEO4J_ROOT}/development/data/databases/graph.db/*

# neo4j-import to load delimited parsed data into Neo4j graph database
neo4j-import                                               \
--into "${NEO4J_ROOT}/development/data/databases/graph.db"            \
--delimiter '|'                                            \
--stacktrace 'true'                                        \
--bad-tolerance 20000																			 \
--nodes         "${DATA}/All_Mammalia.gene_info.out"       \
--nodes         "${DATA}/All_Plants.gene_info.out"         \
--nodes         "${DATA}/KEGGNodeOut.csv"                  \
--nodes         "${DATA}/Mammalian_Phenotype_Ontology.csv" \
--nodes         "${DATA}/plant_ontology.csv"               \
--nodes         "${DATA}/chebi_ontology.csv"               \
--nodes         "${DATA}/disease_ontology.csv"             \
--nodes         "${DATA}/gene_ontology.csv"                \
--nodes         "${DATA}/human_phenotype.csv"              \
--nodes         "${DATA}/meshNodeOut.csv"                  \
--nodes         "${DATA}/nalNodeOut.csv"                   \
--nodes         "${DATA}/plant_trait_ontology.csv"         \
--nodes         "${DATA}/taxNodeOut.csv"                   \
--nodes         "${DATA}/ttdNodeOut.csv"                   \
--nodes         "${DATA}/ttdNodeOut2.csv"                  \
--nodes         "${DATA}/wikiNodeOut.csv"                  \
--relationships "${DATA}/gene2go.out"                      \
--relationships "${DATA}/gene_group.out"                   \
--relationships "${DATA}/linguaRelnOut.csv"								 \
--relationships "${DATA}/meshRelnOut.csv"                  \
--relationships "${DATA}/nalRelnOut.csv"                   \
--relationships "${DATA}/oboRelnOut.csv"                   \
--relationships "${DATA}/targetKEGGRelnOut.csv"            \
--relationships "${DATA}/targetWikiRelnOut.csv"            \
--relationships "${DATA}/taxRelnOut.csv"

#IMPORT=( "neo4j-import" "--into" "${NEO4J_ROOT}/development/databases/graph.db/" "--delimiter" "|" "--stacktrace" "true" )
#for file in ${data}/nodes/*.csv; do
#	IMPORT[${#IMPORT}]="--nodes"
#	IMPORT[${#IMPORT}]="${file}"
#done
#
#
#for file in ${data}/relationships/*.csv; do
#	IMPORT[${#IMPORT}]="--relationships"
#	IMPORT[${#IMPORT}]="${file}"
#done
#
#"${IMPORT[@]}"
