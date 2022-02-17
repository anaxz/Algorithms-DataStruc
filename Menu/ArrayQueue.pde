class ArrayQueue {
  private int front, back;
  private Object[] array;
  public static final int max = 100;

  ArrayQueue(){
    front = 0;
    back = 0;
    array = new Object[max];
  }
  
  //is queue empty?
  public boolean isEmpty(){
    return ((back-front) == 0);
  }
  
  //return size
  public int size(){
    return (back-front);
  }
  
  public Object getFront(){
    return array[front];
  }

  public Object getBack(){
    return array[back];
  }

  //remove item from the front
  public void dequeue(){
    if(!isEmpty()){         //if queue not empty
      array[front] = null;  //remove front
      front++;
    } //else System.out.println("Queue is empty");
  }

  //adding item to the end
  public void enqueue(Object obj){
    if(back < max){      //if queue is not full
      array[back] = obj; //
      back++;
    } //else System.out.println("Queue is full");
  }
  
  //remove all items
  public void dequeueAll(){
    if(isEmpty() == false){
      for(int i = 0; i < back-front; i++){
        dequeue();
      }
    } //else println("Queue is empty");
    //println("Queue emptied complete");
    
    //reset so next items added will be added from queue[0]
    front = 0;
    back = 0;
  }
  
  //display the whole queue in a string
  public String display(){
    String str = "", temp = "";
    
    for(int i = front; i < back; i++){
      if(array[i] == null) break; //if empty break
      if(i != back-1) temp =  array[i] + " -> "; //if not last item, store array 
      
      //println so text won't go off screen but don't println if last item is mod of 8
      if(i%8 == 0 && i != back-1) temp = "\n" + array[i] + " -> ";
      
      //if last item or next item is null, don't put -->
      else if(i == back-1 || array[i+1] == null) temp = "" + array[i];
      str = str + temp; //append next array to string
    }
    return str;
  }
  
  //inherit into new queue
  public void inherit(ArrayQueue q1, ArrayQueue q2){
    for(int i = 0; i < q1.size(); i++) q2.enqueue(q1.array[i]); //add the items from old to new queue
  }
}