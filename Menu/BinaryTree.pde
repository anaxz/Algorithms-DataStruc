//https://www.youtube.com/watch?v=M6lYob8STMI - link to the tutorial I used
class BinaryTree {
  treeNode root, current, parent, newNode;

  boolean empty(){
    return (root == null);
  }

  //add new nodes to a tree
  void addNode(int data){
    newNode = new treeNode(data); //make a new treeNode with data

    //if no root, assign newNode as root
    if(empty()) root = newNode;
    else {
      current = root;

      while(true){
        parent = current;

        //check to see if node should be assigned to the left
        if(data < current.data){
          current = current.leftChild;
          
        //if leftchild has no children, move it to the left of the parent
          if(current == null){
            parent.leftChild = newNode;
            return;
          }
        }
        else {
          current = current.rightChild;
        //if rightchild has no children, move it to the right of the parent
          if(current == null){
            parent.rightChild = newNode;
            return;
          }
        }
      }//end while
    }
  }//end addNode

  //traverse the tree and print the nodes
  void inOrder(treeNode current){
    if(current != null){
      inOrder(current.leftChild); //traverse on the left side
      println(current); //print the current node visited
      inOrder(current.rightChild); //traverse the right side
    } 
  }

  //make a tree empty
  void close(){
    parent = null;
    root = null;
    current = null;
  }
  
  //Combines sub-trees into one whole binary tree
  BinaryTree combine(int v, BinaryTree t1, BinaryTree t2){
    BinaryTree newTree = new BinaryTree();
    treeNode root = new treeNode(v);

    newTree.root = root;
    println("Root: "+newTree.root);

    println("Left subtree:");
    newTree.inOrder(t1.root);

    println("Right subtree:");
    newTree.inOrder(t2.root);

    //empty the trees no longer needed
    t1.close();
    t2.close();
    return newTree;
  }
}

//creates a treeNode
class treeNode {
  int data;
  treeNode leftChild;
  treeNode rightChild;

  treeNode(int data){
    this.data = data;
  }

  //need this to print data and convert to string
  public String toString(){
    return data + " ";
  }
}