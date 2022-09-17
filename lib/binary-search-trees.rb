# Node class
class Node
  attr_accessor :data, :left, :right

  include Comparable
  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# Tree class
class Tree
  attr_accessor :root # Temporary attribute accessor, just to inspect objects when printing

  def initialize(array = nil)
    @root = array.nil? ? nil : build_tree(array, 0, array.length - 1)
  end

  # Builds a balanced binary tree full of Node objects
  # returns the level-0 root node
  def build_tree(array, start_arr, end_arr)
    return nil if array.nil? || array.empty?
    # base case
    return nil if start_arr > end_arr

    # find the middle index
    mid = (start_arr + end_arr) / 2

    # make the middle element the root
    root = Node.new(array[mid])

    # left subtree of root has all values <arr[mid]
    root.left = build_tree(array, start_arr, mid - 1)

    # right subtree of root has all values >arr[mid]
    root.right = build_tree(array, mid + 1, end_arr)

    root
  end

  # Inserts a key as a leaf node
  def insert; end

  def delete; end

  def find
    # Start from the root.
    # Compare the searching element with root, if less than root, then recursively call left subtree, else recursively call right subtree.
    # If the element to search is found anywhere, return true, else return false.
  end

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
    return if @root.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

def sorted_unique(array)
  array.uniq.sort
end

# Do not use duplicate values because they make it more complicated and result in trees that are much harder to balance. Therefore, be sure to always remove duplicate values or check for an existing value before inserting.
# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = Tree.new(sorted_unique(array))
tree.pretty_print
tree.insert(31)
tree.pretty_print
