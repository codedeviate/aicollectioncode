package main

import "fmt"

// Double Linked List Node
type DLLNode struct {
	data int
	prev *DLLNode
	next *DLLNode
}

// B-Tree Node
type BTreeNode struct {
	keys     []int
	children []*BTreeNode
	leaf     bool
	numKeys  int
	dllHead  *DLLNode // Pointer to the first DLL node in the B-Tree node
	dllTail  *DLLNode // Pointer to the last DLL node in the B-Tree node
	data     int
}

// B-Tree
type BTree struct {
	root *BTreeNode
	t    int // Minimum degree
}

// Create a new Double Linked List Node
func NewDLLNode(data int) *DLLNode {
	return &DLLNode{data: data}
}

// Create a new B-Tree Node
func NewBTreeNode(t int, data int, leaf bool) *BTreeNode {
	return &BTreeNode{
		keys:     make([]int, 2*t-1),
		children: make([]*BTreeNode, 2*t),
		leaf:     leaf,
		data:     data,
	}
}

// Create a new B-Tree with minimum degree t
func NewBTree(t int) *BTree {
	root := NewBTreeNode(t, 0, true)
	return &BTree{root: root, t: t}
}

// Insert into the B-Tree
func (bt *BTree) Insert(data int) {
	root := bt.root
	// If root is full, create a new node and split the old root
	if root.numKeys == len(root.keys) {
		newRoot := NewBTreeNode(bt.t, data, false)
		newRoot.children[0] = root
		bt.splitChild(newRoot, 0)
		bt.root = newRoot
	}
	bt.insertNonFull(bt.root, data)
}

// Split a child of a B-Tree node
func (bt *BTree) splitChild(parent *BTreeNode, index int) {
	t := bt.t
	child := parent.children[index]
	newNode := NewBTreeNode(t, child.data, child.leaf)

	// Move the middle key from the child to the parent
	parent.keys = append(parent.keys[:index], append([]int{child.keys[t-1]}, parent.keys[index:]...)...)
	parent.children = append(parent.children[:index+1], append([]*BTreeNode{newNode}, parent.children[index+1:]...)...)

	// Transfer the keys and children from the child node to the new node
	for i := t; i < len(child.keys); i++ {
		newNode.keys = append(newNode.keys, child.keys[i])
	}
	child.keys = child.keys[:t-1]

	if !child.leaf {
		for i := t; i < len(child.children); i++ {
			newNode.children = append(newNode.children, child.children[i])
		}
		child.children = child.children[:t]
	}

	// Insert the new DLLNode into the parent and new child
	bt.insertDLLNode(parent, newNode)

	parent.numKeys++
	newNode.numKeys = t - 1
}

// Insert a DLLNode into a B-Tree node's DLL
func (bt *BTree) insertDLLNode(node *BTreeNode, newChild *BTreeNode) {
	newNode := NewDLLNode(newChild.data)
	if node.dllHead == nil {
		node.dllHead = newNode
		node.dllTail = newNode
	} else {
		node.dllTail.next = newNode
		newNode.prev = node.dllTail
		node.dllTail = newNode
	}
}

// Insert a key into a B-Tree node that is not full
func (bt *BTree) insertNonFull(node *BTreeNode, data int) {
	index := node.numKeys - 1

	if node.leaf {
		// Find the position for the new key
		for index >= 0 && node.keys[index] > data {
			index--
		}
		index++

		// Shift the keys and insert the new key
		node.keys = append(node.keys[:index], append([]int{data}, node.keys[index:]...)...)
		node.numKeys++

		// Insert the new key into the DLL
		bt.insertDLLNode(node, NewBTreeNode(bt.t, data, false))
	} else {
		// Find the child that will have the new key
		for index >= 0 && node.keys[index] > data {
			index--
		}
		index++

		// If the child is full, split it
		if node.children[index].numKeys == len(node.children[index].keys) {
			bt.splitChild(node, index)
			// After splitting, the middle key will be moved to the parent
			if data > node.keys[index] {
				index++
			}
		}
		bt.insertNonFull(node.children[index], data)
	}
}

// Search for a key in the B-Tree
func (bt *BTree) Search(node *BTreeNode, data int) *BTreeNode {
	i := 0
	for i < node.numKeys && data > node.keys[i] {
		i++
	}

	if i < node.numKeys && node.keys[i] == data {
		return node
	}

	if node.leaf {
		return nil
	}

	return bt.Search(node.children[i], data)
}

// Traverse DLL from head to tail
func (bt *BTree) TraverseDLLFromHead(node *BTreeNode) {
	current := node.dllHead
	for current != nil {
		fmt.Printf("%d ", current.data)
		current = current.next
	}
	fmt.Println()
}

// Print the B-Tree structure
func (bt *BTree) Print() {
	bt.printNode(bt.root, 0)
}

// Print a B-Tree node
func (bt *BTree) printNode(node *BTreeNode, level int) {
	fmt.Printf("Level %d: ", level)
	for i := 0; i < node.numKeys; i++ {
		fmt.Printf("%d ", node.keys[i])
	}
	fmt.Println()

	// Traverse DLL from head to tail
	bt.TraverseDLLFromHead(node)

	if !node.leaf {
		for i := 0; i <= node.numKeys; i++ {
			bt.printNode(node.children[i], level+1)
		}
	}
}

func main() {
	// Create a new B-Tree with minimum degree 3
	bTree := NewBTree(3)

	// Insert elements
	bTree.Insert(10)
	bTree.Insert(20)
	bTree.Insert(5)
	bTree.Insert(6)
	bTree.Insert(12)
	bTree.Insert(30)
	bTree.Insert(7)
	bTree.Insert(17)

	// Print the B-Tree and DLL traversal
	bTree.Print()

	// Search for a key
	if result := bTree.Search(bTree.root, 12); result != nil {
		fmt.Println("Found:", 12)
	} else {
		fmt.Println("Not found:", 12)
	}
}
