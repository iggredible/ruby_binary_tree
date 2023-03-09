require "minitest/autorun"
require "./tree_node"

describe TreeNode do
  before do
    @tree_node = TreeNode.new(value: 1)
  end

  it "returns a value" do
    assert_equal @tree_node.value, 1
  end

  describe "when given other nodes" do
    it "returns a left node" do
      left_node = TreeNode.new(value: 2)
      @tree_node.left = left_node
      assert_equal @tree_node.left, left_node
    end

    it "returns a right node" do
      right_node = TreeNode.new(value: 3)
      @tree_node.right = right_node
      assert_equal @tree_node.right, right_node
    end
  end
end
