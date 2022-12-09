# Binary Search Trees
My OOP implementation of a *balanced* binary search tree (BST) using `ruby`. 

**Limitations**
* Initial input array must be sorted, with no duplicate values.

### Background
* A binary Search Tree is a node-based binary tree data structure which has the following properties:  
  * The left subtree of a node contains only nodes with keys lesser than the node’s key.
  * The right subtree of a node contains only nodes with keys greater than the node’s key.
  * The left and right subtree each must also be a binary search tree. 
  * There must be no duplicate nodes.
* The above properties of Binary Search Tree provides an ordering among keys so that the operations like search, minimum and maximum can be done fast. If there is no ordering, then we may have to compare every key to search for a given key.

### Additional Resources
* [Wiki](https://en.wikipedia.org/wiki/Binary_search_tree)
* [Constructing a BST](https://www.youtube.com/watch?v=VCTP81Ij-EM)
* [Binary Tree Traversal](https://www.youtube.com/watch?v=9RHO6jU--GU)
* [Breadth-first Traversal](https://www.youtube.com/watch?v=86g8jAQug04)
* [Depth-first Traversal](https://www.youtube.com/watch?v=gm8DUJJhmY4)
* [Insertion and Deletion 1](https://www.geeksforgeeks.org/binary-search-tree-set-1-search-and-insertion/?ref=lbp) 
* [Insertion and Deletion 2](https://www.youtube.com/watch?v=wcIRPqTR3Kc)
* [Deletion](https://www.youtube.com/watch?v=gcULXE7ViZw&vl=en)
* [Height and Maximum Depth](https://www.youtube.com/watch?v=_pnqMz5nrRs)

### Psuedocode Notes
#### BST Construction Algorithm
1. Initialize start = 0, end = length of the array - 1
2. mid = (start + end) / 2
3. Create a tree node with mid as root (A)
4. Recursively perform the following steps. 
  1. Calculate mid of left subarray and make it root of left subtree of A
  2. Calculate mid of right subarray and make it root of right subtree of A

#### Insertion
* The insertion item is always inserted into a BST as a leaf
* Begin at the root, and directed to left or right base on if the value is less than or greater than current node, respectively
* Traverse until we find a node that can accomodate the insertion of the item

#### Deletion
Three cases must be considered:
1. No children (leaf)
  * Can delete without changing structure of tree (delete child)
2. One child
  * Point the parent to it's child child
3. Two children
  * Want look for next biggest of item being deleted
  * Look in right subtree, then find leftmost item, i.e. until no left (i)
    * If (i) has no children
      * replace the iteDeleting a node with 2 children:m being deleted with (i)
    * If (i) has children (right subtrees)
      * replace the item being deleted with (i)
      * replace (i)'s original position with (i)'s original immediate right subtree

### Final Implementation in Ruby
```ruby
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
  # A balanced tree is one where the difference between heights of left 
  # subtree and right subtree of every node is not more than 1.
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
```




### Example Usage
```ruby
puts "\nBuild new tree from sorted array"
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
```

```
Build new tree from sorted array
│           ┌── 6345
│       ┌── 324
│   ┌── 67
│   │   │   ┌── 23
│   │   └── 9
└── 8
    │       ┌── 7
    │   ┌── 5
    └── 4
        │   ┌── 3
        └── 1
```

```ruby
puts "\nBuild new tree from sorted array, insert key"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.insert(31)
tree.pretty_print
```

```
Build new tree from sorted array, insert key
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │       ┌── 31
        │   ┌── 30
        └── 20
```

```ruby
puts "\nBuild new tree (empty), add single node"
tree = BinarySearchTree.new
tree.insert(31)
tree.pretty_print
```

```
Build new tree (empty), add single node
└── 31
```

```ruby
puts "\nBuild new tree from sorted array, and delete keys: 30, 50"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.delete(30)
tree.pretty_print
tree.delete(50)
tree.pretty_print
```

```

Build new tree from sorted array, and delete keys: 30, 50
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        └── 20
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   └── 65
└── 60
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        └── 20
```

```ruby
puts "\nBuild new tree from sorted array, check presence of keys"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
puts "Value: 50, should return true: #{tree.find(50)}"
puts "Value: 777, should return false: #{tree.find(777)}"
puts "Value: 80, should return true: #{tree.find(80)}"
puts "Value: 85, should return true: #{tree.find(85)}"
```

```
Build new tree from sorted array, check presence of keys
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
Value: 50, should return true: true
Value: 777, should return false: false
Value: 80, should return true: true
Value: 85, should return true: true
```

```ruby
puts "\nBuild new tree from sorted array, level_order accepts block, or returns array if no block passed"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.level_order { |node| puts node.key }
level_ordering = tree.level_order
p level_ordering.inject([]) { |acc, node| acc << node.key }
```

```
Build new tree from sorted array, level_order accepts block, or returns array if no block passed
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
50
32
70
20
36
60
80
30
34
40
65
75
85
[50, 32, 70, 20, 36, 60, 80, 30, 34, 40, 65, 75, 85]
```

```ruby
puts "\nBuild new tree from sorted array, return preorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.preorder { |node| puts node.key }
preordering = tree.preorder
p preordering.inject([]) { |acc, node| acc << node.key }
```

```
Build new tree from sorted array, return preorder
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
50
32
20
30
36
34
40
70
60
65
80
75
85
[50, 32, 20, 30, 36, 34, 40, 70, 60, 65, 80, 75, 85]
```

```ruby
puts "\nBuild new tree from sorted array, return postorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.postorder { |node| puts node.key }
postordering = tree.postorder
p postordering.inject([]) { |acc, node| acc << node.key }
```

```
Build new tree from sorted array, return postorder
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
30
20
34
40
36
32
65
60
75
85
80
70
50
[30, 20, 34, 40, 36, 32, 65, 60, 75, 85, 80, 70, 50]
```

```ruby
puts "\nBuild new tree from sorted array, return inorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.inorder { |node| puts node.key }
inordering = tree.inorder
p inordering.inject([]) { |acc, node| acc << node.key }
```

```
Build new tree from sorted array, return inorder
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
20
30
32
34
36
40
50
60
65
70
75
80
85
[20, 30, 32, 34, 36, 40, 50, 60, 65, 70, 75, 80, 85]
```

```ruby
puts "\nBuild new tree from sorted array, find the height of the tree"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
p "BST Height: #{tree.height}"
tree = BinarySearchTree.new
p "Empty Tree Height: #{tree.height}"
```

```
Build new tree from sorted array, find the height of the tree
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
"BST Height: 3"
"Empty Tree Height: 0"
```

```ruby
puts "\nBuild new tree from sorted array, find depth of a node"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
puts "Depth of 32 should be 1: #{tree.depth(32)}"
puts "Depth of 30 be 3: #{tree.depth(30)}"
puts "Depth of 50 be 0: #{tree.depth(50)}"
```

```
Build new tree from sorted array, find depth of a node
│           ┌── 85
│       ┌── 80
│       │   └── 75
│   ┌── 70
│   │   │   ┌── 65
│   │   └── 60
└── 50
    │       ┌── 40
    │   ┌── 36
    │   │   └── 34
    └── 32
        │   ┌── 30
        └── 20
Depth of 32 should be 1: 1
Depth of 30 be 3: 3
Depth of 50 be 0: 0
```

```ruby
puts "\nCreate an unbalanced tree, then rebalance it"
tree = BinarySearchTree.new
tree.insert(4)
tree.insert(3)
tree.insert(5)
tree.insert(2)
tree.insert(6)
tree.insert(1)
tree.insert(7)
tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
tree.rebalance
tree.pretty_print
puts "Is the tree balanced?: #{tree.balanced?}"
```

```
Create an unbalanced tree, then rebalance it
│           ┌── 7
│       ┌── 6
│   ┌── 5
└── 4
    └── 3
        └── 2
            └── 1
Is the tree imbalanced?: false
│       ┌── 7
│   ┌── 6
│   │   └── 5
└── 4
    │   ┌── 3
    └── 2
        └── 1
Is the tree imbalanced?: true
```
