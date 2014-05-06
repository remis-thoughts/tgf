require 'minitest/autorun'
require 'tgf'
require 'tempfile'

class TGFParseTest < Minitest::Test
  def test_simple
    nodes, edges = TGF.parse "1\n2\n#\n1 2\n"
    assert_equal 2, nodes.size
    assert_equal 1, edges.size

    assert_equal '1', nodes[0].id
    assert_nil nodes[0].label

    assert_equal '2', nodes[1].id
    assert_nil nodes[1].label

    assert_equal '1', edges[0].from
    assert_equal '2', edges[0].to
    assert_nil edges[0].label
  end

  def test_custom_separator
    nodes, edges = TGF.parse '1;2;#;1 2;', ';'
    assert_equal 2, nodes.size
    assert_equal 1, edges.size

    assert_equal '1', nodes[0].id
    assert_nil nodes[0].label

    assert_equal '2', nodes[1].id
    assert_nil nodes[1].label

    assert_equal '1', edges[0].from
    assert_equal '2', edges[0].to
    assert_nil edges[0].label
  end

  def test_node_label
    nodes, edges = TGF.parse "1 hat\n"
    assert_equal 1, nodes.size

    assert_equal '1', nodes[0].id
    assert_equal 'hat', nodes[0].label
  end

  def test_edge_label
    nodes, edges = TGF.parse "#\n1 2 hat\n"
    assert_equal 1, edges.size

    assert_equal '1', edges[0].from
    assert_equal '2', edges[0].to
    assert_equal 'hat', edges[0].label
  end

  def test_file_simple
    file = Tempfile.new('tgf')
    file.write "1\n2\n#\n1 2\n"
    file.rewind
    nodes, edges = TGF.parse file
    assert_equal 2, nodes.size
    assert_equal 1, edges.size

    assert_equal '1', nodes[0].id
    assert_nil nodes[0].label

    assert_equal '2', nodes[1].id
    assert_nil nodes[1].label

    assert_equal '1', edges[0].from
    assert_equal '2', edges[0].to
    assert_nil edges[0].label
    file.close!
  end
end

class TGFWriteTest < Minitest::Test
  def node id, label = nil
    TGF::Node.new (label.nil? ? id.to_s : "#{id} #{label}")
  end

  def edge from, to, label = nil
    TGF::Edge.new (label.nil? ? "#{from} #{to}" : "#{from} #{to} #{label}")
  end

  def test_simple
    text = TGF.write '', [node(1), node(2)], [edge(1,2)]
    assert_equal "1\n2\n#\n1 2\n", text
  end

  def test_custom_separator
    text = TGF.write '', [node(1), node(2)], [edge(1,2)], ';'
    assert_equal "1;2;#;1 2;", text
  end

  def test_node_label
    text = TGF.write '', [node(1, 'hat')]
    assert_equal "1 hat\n", text
  end

  def test_edge_label
    text = TGF.write '', [], [edge(1, 2, 'hat')]
    assert_equal "#\n1 2 hat\n", text
  end

  def test_file_simple
    file = Tempfile.new('tgf')
    TGF.write file, [node(1), node(2)], [edge(1,2)]
    file.rewind
    assert_equal "1\n2\n#\n1 2\n", file.read
    file.close!
  end
end

