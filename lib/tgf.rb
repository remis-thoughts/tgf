
##
# A module to read the Trivial Graph Format

module TGF

  class Node
    def initialize line
      match = /^(\S+)(?:\s+(.*))?$/.match line.chomp
      @id, @label = match[1], match[2]
    end
    attr_reader :id, :label
  end

  class Edge
    def initialize line
      match = /^(\S+)\s+(\S+)(?:\s+(.*))?$/.match line.chomp
      @from, @to, @label = match[1], match[2], match[3]
    end
    attr_reader :from, :to, :label
  end

  ##
  # Parses a file using +each_line+ returning two values; an
  # +Array+ of +TGF::Node+s and an +Array+ of +TGF::Edge+s.

  def self.parse file
    parsing_nodes, nodes, edges = true, [], []
    
    file.each_line do |line|
      if line.strip == '#'
        parsing_nodes = false
      elsif parsing_nodes
        nodes << Node.new(line)
      else
        edges << Edge.new(line)
      end
    end

    return nodes, edges
  end
end
