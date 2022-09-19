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
  # inorder: left > root > right
  # Returns an array if no block given
  def inorder(root = @root, array = [], &block)
    if root.nil?
      if block_given?
        return
      else
        return array
      end
    end
    inorder(root.left, array, &block)
    block.call(root) if block_given?
    array.push(root)
    inorder(root.right, array, &block)
  end

  # Traverse the three in depth-first order (preorder) and yield each node to given block
  # preorder: root > left > right
  # Returns an array if no block given
  def preorder(root = @root, array = [], &block)
    if root.nil?
      if block_given?
        return
      else
        return array
      end
    end
    block.call(root) if block_given?
    array.push(root)
    preorder(root.left, array, &block)
    preorder(root.right, array, &block)
  end

  # Traverse the three in depth-first order (postorder) and yield each node to given block
  # postorder: left > right > root
  # Returns an array if no block given
  def postorder(root = @root, array = [], &block)
    if root.nil?
      if block_given?
        return
      else
        return array
      end
    end
    postorder(root.left, array, &block)
    postorder(root.right, array, &block)
    block.call(root) if block_given?
    array.push(root)
  end

  # Given a node, return its height
  # height = # edges in longest path from root to leaf node
  def height(node = @root)
    # guard case, return 0 if empty tree
    return 0 if @root.nil?
    # base case
    # return -1 to account for the edge to nil
    return -1 if node.nil?

    # recursive case
    left_height = height(node.left)
    right_height = height(node.right)
    [left_height, right_height].max + 1
  end

  # Given a node, return its depth
  # depth = # edges in path from root to that node
  def depth(key, root = @root)
    # base case
    return -1 if root.nil?

    # initialize distance as -1
    dist = -1

    # check if key is current node
    return dist + 1 if root.key == key

    dist = depth(key, root.left)
    return dist + 1 if dist >= 0

    dist = depth(key, root.right)
    return dist + 1 if dist >= 0

    dist
  end

  # Given a BST, check if the tree is balanced
  # A balanced tree is one where the difference
  # between heights of left subtree and right
  # subtree of every node is not more than 1.
  def balanced?
    nodes_inorder = inorder(@root)
    nodes_inorder.each do |node|
      return false if (height(node.left) - height(node.right)).abs > 1
    end
    true
  end

  # Rebalances an unbalanced tree
  # rebuilds the tree using inorder traversal to recover the sorted array
  def rebalance
    nodes_inorder = inorder(@root)
    keys = nodes_inorder.inject([]) { |acc, node| acc << node.key }
    @root = build_tree(keys, 0, keys.length - 1)
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
