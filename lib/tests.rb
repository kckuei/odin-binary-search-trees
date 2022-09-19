require_relative './binary-search-trees'

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

puts "\nBuild new tree from sorted array, return preorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.preorder { |node| puts node.key }
preordering = tree.preorder
p preordering.inject([]) { |acc, node| acc << node.key }

puts "\nBuild new tree from sorted array, return postorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.postorder { |node| puts node.key }
postordering = tree.postorder
p postordering.inject([]) { |acc, node| acc << node.key }

puts "\nBuild new tree from sorted array, return inorder"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
tree.inorder { |node| puts node.key }
inordering = tree.inorder
p inordering.inject([]) { |acc, node| acc << node.key }

puts "\nBuild new tree from sorted array, find the height of the tree"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
p "BST Height: #{tree.height}"
tree = BinarySearchTree.new
p "Empty Tree Height: #{tree.height}"

puts "\nBuild new tree from sorted array, find depth of a node"
array = [20, 30, 50, 40, 32, 34, 36, 70, 60, 65, 75, 80, 85]
tree = BinarySearchTree.new(sorted_unique(array))
tree.pretty_print
puts "Depth of 32 should be 1: #{tree.depth(32)}"
puts "Depth of 30 be 3: #{tree.depth(30)}"
puts "Depth of 50 be 0: #{tree.depth(50)}"

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
