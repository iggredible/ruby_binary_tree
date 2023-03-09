require './tree_node'

class BinarySearchTree
  attr_accessor :root

  def initialize(root: nil)
    @root = root
  end

  def insert!(value:)
    if root.nil?
      @root = TreeNode.new(value: value)
    else
      current_node = find_edge(current_node: @root, value: value)

      if value < current_node.value
        current_node.left = TreeNode.new(value: value)
      else
        current_node.right = TreeNode.new(value: value)
      end
    end
  end

  def reset!
    @root = nil
  end

  def size(node: @root)
    if node.nil?
      return 0
    end

    sum_left = size(node: node.left)
    sum_right = size(node: node.right)

    1 + sum_left + sum_right
  end

  def contains?(value:, node: @root)
    if node.nil?
      return false
    elsif value < node.value
      contains?(value: value, node: node.left)
    elsif value > node.value
      contains?(value: value, node: node.right)
    else
      return true
    end
  end

  def max(node: @root)
    return nil if node.nil?

    node.right.nil? ? node : max(node: node.right)
  end

  def min(node: @root)
    return nil if node.nil?

    node.left.nil? ? node : min(node: node.left)
  end

  # in-order traversal
  def remove!(value:, node: @root)
    node = node_remover!(value: value, node: node)
    @root = node
    node 
  end

  private

  def node_remover!(value:, node:)
    return nil if node.nil?

    if node.value > value
      node.left = node_remover!(value: value, node: node.left)
    elsif node.value < value
      node.right = node_remover!(value: value, node: node.right)
    else
      if node.left != nil && node.right != nil
        min_of_left_subtree = min(node: node.left)
        node.value = min_of_left_subtree.value
        node.left = node_remover!(value: min_of_left_subtree.value, node: node.left)
      elsif node.left != nil
        node = node.left
      elsif node.right != nil
        node = node.right
      else
        node = nil
      end
    end

    node
  end

  def find_edge(current_node:, value:)
    next_node = current_node

    while next_node != nil
      current_node = next_node
      if value < current_node.value
        next_node = current_node.left
      else
        next_node = current_node.right
      end
    end

    current_node
  end
end
