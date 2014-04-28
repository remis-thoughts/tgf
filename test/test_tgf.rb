require 'minitest/autorun'
require 'tgf'

class TGFTest < Minitest::Test
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
end
