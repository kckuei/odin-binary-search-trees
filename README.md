# odin-binary-search-trees
My OOP implementation of a *balanced* binary search tree (BST) with `ruby`. 

# Binary Search Trees (BSTs)
* A binary Search Tree is a node-based binary tree data structure which has the following properties:  
  * The left subtree of a node contains only nodes with keys lesser than the node’s key.
  * The right subtree of a node contains only nodes with keys greater than the node’s key.
  * The left and right subtree each must also be a binary search tree. 
  * There must be no duplicate nodes.
* The above properties of Binary Search Tree provides an ordering among keys so that the operations like search, minimum and maximum can be done fast. If there is no ordering, then we may have to compare every key to search for a given key.

### References
* [Wiki](https://en.wikipedia.org/wiki/Binary_search_tree)
* [Constructing a BST](https://www.youtube.com/watch?v=VCTP81Ij-EM)
* [Binary Tree Traversal](https://www.youtube.com/watch?v=9RHO6jU--GU)
* [Breadth-first Traversal](https://www.youtube.com/watch?v=86g8jAQug04)
* [Depth-first Traversal](https://www.youtube.com/watch?v=gm8DUJJhmY4)
* [Insertion and Deletion 1](https://www.geeksforgeeks.org/binary-search-tree-set-1-search-and-insertion/?ref=lbp) [Insertion and Deletion 2](https://www.youtube.com/watch?v=wcIRPqTR3Kc)

### BST Construction Algorithm
1. Initialize start = 0, end = length of the array - 1
2. mid = (start + end) / 2
3. Create a tree node with mid as root (A)
4. Recursively perform the following steps. 
  1. Calculate mid of left subarray and make it root of left subtree of A
  2. Calculate mid of right subarray and make it root of right subtree of A

### Insertion
* The insertion item is always inserted into a BST as a leaf
* Begin at the root, and directed to left or right base on if the value is less than or greater than current node, respectively
* Traverse until we find a node that can accomodate the insertion of the item

### Deletion
* Three cases must be considered
1. Leaf: 
  * Can delete without changing structure of tree (delete child)
2. Deleting node with 1 child:
  * Point the parent to it's child child
3. Deleting a node with 2 children:
  * Want look for next biggest of item being deleted
  * Look in right subtree, then find leftmost item, i.e. until no left (i)
    * If (i) has no children
      * replace the item being deleted with (i)
    * If (i) has children (right subtrees)
      * replace the item being deleted with (i)
      * replace (i)'s original position with (i)'s original immediate right subtree