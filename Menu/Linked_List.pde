//ref:https://www.youtube.com/watch?v=195KUinjBpU - link to the tutorial I used
public class Linked_List {
  private Node head = null;
  private int count = 0;
  
  public boolean isEmpty(){ //return whether it's empty
    return (head == null);
  }
  
  public int size(){ //return size of linked list
    return count;
  }
  
  public Node getHead(){ //return first node
    return head;
  }
  
  //creating/inserting nodes before head
  public void insert(Object rabPath, Object chePath){
    Node newNode = new Node(rabPath, chePath); //make new node
    newNode.next = head;   //newNode.next point to previous node
    head = newNode;        //new Node is the head now
    count++;               //increase size
  }
  
  //remove from head
  public void Remove(){
    head = head.next; //change next item to head
    count--; //decrease size
  }
  
  //print the list
  public String display(){
    Node temp = head;
    String str = "";
    
    //if node not = null
    while(temp != null){
      str = "Rabbit Path: "+temp.rabPath + "\n" + "Cheetah Path: "+temp.chePath; //print current node
      temp = temp.next; //check next node
      //count++; //add each time if there is a node
    }
    return str;
  }
}

//------------Node Class------------//
public class Node {
  public Object rabPath, chePath;
  public Node next; //this is needed for reference next node
  
  //used for insert function
  public Node(Object rabPath, Object chePath){
    this.rabPath = rabPath;
    this.chePath = chePath;
    next = null;
  }
  
  //main Constructor
  public Node(Object rabPath, Object chePath, Node next){
    this.rabPath = rabPath;
    this.chePath = chePath;
    this.next = next;
  }
}