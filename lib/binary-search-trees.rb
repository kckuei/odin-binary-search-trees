# Node class
class Node
  attr_accessor :key, :left, :right

  include Comparable
  def initialize(key = nil, left = nil, right = nil)
    @key = key
    @left = left
    @right = right
  end
end

# Binary Search Tree class
class BinarySearchTree
  attr_accessor :root # Temporary attribute accessor for inspect

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
  def insert(key, root = @root)
    # guard against initial empty tree
    return @root = Node.new(key) if @root.nil?

    # recursive base case
    return Node.new(key) if root.nil?

    # traverse left or right by comparing key and current node value
    if key > root.key
      root.right = insert(key, root.right)
    else
      root.left = insert(key, root.left)
    end
    root
  end

  # Given non-empty BST, return minimum key value node
  def min_value_node(node)
    current = node
    current = current.left unless current.left.nil?
    current
  end

  # Given a key and BST root node, deletes the key from the tree
  def delete(key, root = @root)
    # recursive base case
    if root.nil?
      return root
    # if they key to be deleted is smaller than the root's key then it lies in left subtree
    elsif key < root.key
      root.left = delete(key, root.left)
    # if the key to be deleted is greater than the root's key then it lies in the right subtree
    elsif key > root.key
      root.right = delete(key, root.right)
    # if key is same as root's key, then this is to be deleted
    elsif key == root.key
      # case 1: no child
      if root.left.nil? && root.right.nil?
        root = nil
      # case 2: one child
      elsif root.left.nil?
        root = root.right
      elsif root.right.nil?
        root = root.left
      # case 3: two children
      else
        # Node with two children: get the inorder successor
        # (smallest in the right subtree)
        temp = min_value_node(root.right)

        # Copy the inorder successor's content to this node
        root.key = temp.key

        # Delete the inorder successor
        root.right = delete(temp.key, root.right)
      end
    end

    root
  end

  # Given a key, and BST root, checks existence of a key
  def find(key, root = @root)
    # recursive base case - nil
    if root.nil?
      false
    # recursive base case - found key
    elsif key == root.key
      true
    # recursive case - the search key is less than the root key,
    # then the value lies in the left subtree
    elsif key < root.key
      find(key, root.left)
    # recursive case - the search key is less than the root key,
    # then the value lies in the right subtree
    elsif key > root.key
      find(key, root.right)
    end
  end

  # Traverse the tree in breadth-first level order and yields each node to the provided block
  # Returns array unless block given
  def level_order(root = @root, &block)
    return if root.nil?

    array = []
    queue = []
    queue.push(root)

    # while there is at least one discovered node
    until queue.empty?
      node = queue.shift
      block.call(node) if block_given? && !node.nil?
      array.push(node)
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
    array unless block_given?
  end

  # Traverse the three in depth-first order (inorder) and yield each node to given block
  # Returns an array if no block given
  def inorder; end

  # Traverse the three in depth-first order (preorder) and yield each node to given block
  # Returns an array if no block given

  def preorder; end
  # Traverse the three in depth-first order (postorder) and yield each node to given block
  # Returns an array if no block given
  def postorder; end

  # Given a node, return its height
  def height
    # Height is defined as the number of edges in longest path from a given node to a leaf node.
  end

  # Given a node, return its depth
  def depth
    # Depth is defined as the number of edges in path from a given node to the tree’s root node.
  end

  # Given a BST, check if the tree is balanced
  def balanced?
    # A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.
  end

  # Rebalances an unbalanced tree
  def rebalance
    # Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if @root.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.key}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

def sorted_unique(array)
  array.uniq.sort
end

puts "\nBuild new tree from sorted array"
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print

puts "\nBuild new tree from sorted array, insert key"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.insert(31)
tree.pretty_print

puts "\nBuild new tree (empty), add single node"
tree = BinarySearchTree.new
tree.insert(31)
tree.pretty_print

puts "\nBuild new tree from sorted array, and delete keys: 30, 50"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.delete(30)
tree.pretty_print
tree.delete(50)
tree.pretty_print

puts "\nBuild new tree from sorted array, check presence of keys"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
puts "Value: 50, should return true: #{tree.find(50)}"
puts "Value: 777, should return false: #{tree.find(777)}"
puts "Value: 80, should return true: #{tree.find(80)}"
puts "Value: 85, should return true: #{tree.find(85)}"

puts "\nBuild new tree from sorted array, level_order accepts block, or returns array if no block passed"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.level_order { |node| puts node.key }
level_ordering = tree.level_order
p level_ordering.inject([]) { |acc, node| acc << node.key }
