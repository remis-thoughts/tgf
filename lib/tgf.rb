
##
# A module to read the Trivial Graph Format

module TGF

  class Node
    def initialize line
      match = /^(\S+)(?:\s+(.*))?$/.match line
      @id, @label = match[1], match[2]
    end
    attr_reader :id, :label
  end

  class Edge
    def initialize line
      match = /^(\S+)\s+(\S+)(?:\s+(.*))?$/.match line
      @from, @to, @label = match[1], match[2], match[3]
    end
    attr_reader :from, :to, :label
  end

  ##
  # Parses a file using +each_line+ returning two values; an
  # +Array+ of +TGF::Node+s and an +Array+ of +TGF::Edge+s.

  def self.parse file, sep = $/
    parsing_nodes, nodes, edges = true, [], []
    
    file.each_line(sep) do |line|
      line.chomp! sep
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

  ##
  # Prints a set of +TGF::Node+s and +TGF::Edge+s to +file+.
  # +file+ can be any object that responds to +<<+; the graph
  # is passed line by line to +<<+, and the return value is
  # used as the object for the next call. The value +<<+ returns
  # in the final invocation is returned by +write+.

  def self.write file, nodes = [], edges = [], sep = $/
    nodes.each do |node|
      label = node.label.nil? ? '' : " #{node.label}"
      file <<= "#{node.id}#{label}#{sep}"
    end
    return file if edges.empty?

    file <<= "##{sep}"
    edges.each do |edge|
      label = edge.label.nil? ? '' : " #{edge.label}"
      file <<= "#{edge.from} #{edge.to}#{label}#{sep}"
    end

    file    
  end
end
