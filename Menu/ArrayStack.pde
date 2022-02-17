import java.util.Arrays;

class ArrayStack {
   private Object[] array;
   private int count;
   public static final int MAX = 10;
  
   public ArrayStack(){
     array = new Object[MAX];
     count = 0;
   }
  
   public Object top(){ // returns last added element
     return array[count];
   }
  
   public void pop(){  // removes last added element
     array[count] = null;
     count--;
   }
  
   public void push(Object obj){  // add element to the stack
     array[count] = obj;
     count++;
   }
  
   public int size(){  // returns the size of the stack
     return count;
   }
  
   public boolean isEmpty(){  // checks if the stack is empty
     return (count == 0);
   }
  
   public void display(){
     System.out.println(Arrays.toString(array));
   }
}