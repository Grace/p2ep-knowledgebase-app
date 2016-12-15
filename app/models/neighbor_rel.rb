class NeighborRel
  include Neo4j::ActiveRel
  #before_save :do_this

  creates_unique

  from_class :Node
  to_class   :Node
  type 'neighbors'

  # property :from_category, type: String
  # property :to_category, type: String
  # property :from_name, type: String
  # property :to_name, type: String

  # property :notes

  # def do_this
  #   #a callback
  # end

end
