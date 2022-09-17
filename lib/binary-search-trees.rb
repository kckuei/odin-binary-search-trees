class Node
  attr_accessor :data, :left, :right

  include Comparable
  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # build balanced binary tree full of Node objects
    # return the level-0 root node
  end

  def insert; end

  def delete; end

  def find; end

  def level_order
    # traverse the tree in breadth-first level order and yield each node to the provided block
    # method can be implemented using either iteration or recursion
    # Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list (as you saw in the video).
  end

  # methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.
  def inorder; end

  def preorder; end

  def postorder; end

  def height
    Write a # height method which accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.
  end

  def depth
    Write a # depth method which accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.
  end

  def balanced?
    Write a # balanced? method which checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.
  end

  def rebalance
    # Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)
