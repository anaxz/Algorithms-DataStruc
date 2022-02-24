//12 rows & col                  //counter: how many times user has played
int world_h = height/2, world_w = width/2, play1_counter = -1, play2_counter = -1;
String typing = "", letter = "";
boolean start = true, play1 = false, play2 = false, end = false, model = false, tree = false,
  record1 = false, record2 = false, rabbitTurn = false, cheetahTurn = false;

//\Declare classes/\\
Platform platform;
Rabbit rabbit;
Cheetah cheetah;
Stage stage;
Collision collision;
Data data;

//\Database structure/\\
//For play screen
ArrayQueue rab_queue, che_queue;
ArrayStack rab_stack, che_stack;
Linked_List link1[] = new Linked_List[50]; //for record score for Part 1
Linked_List link2[] = new Linked_List[50]; //for record store for Part 2
//For part 1
ArrayQueue rabQ1[] = new ArrayQueue[50];
ArrayQueue cheQ1[] = new ArrayQueue[50];
//for Part 2
ArrayQueue rabQ2[] = new ArrayQueue[50];
ArrayQueue cheQ2[] = new ArrayQueue[50];
BinaryTree binaryTree;

void debug(){
  println("start: "+start+" play1: "+play1+" end: "+end+" record1: "+record1+" play1_counter: "+play1_counter);
  //println("play1_counter: "+play1_counter+" Queue size: "+rab_queue.size());
}

void setup(){
  size(600, 600);
  stage = new Stage();
  platform = new Platform();
  rabbit = new Rabbit(275, 275);
  cheetah = new Cheetah(75, 75);
  rab_queue = new ArrayQueue();
  che_queue = new ArrayQueue();
  rab_stack = new ArrayStack();
  che_stack = new ArrayStack();
  collision = new Collision();
  data = new Data();
  binaryTree = new BinaryTree();
  
  for(int i = 0; i < 50; i++){
    link1[i] = new Linked_List();
    link2[i] = new Linked_List();
    rabQ1[i] = new ArrayQueue();
    cheQ1[i] = new ArrayQueue();
    rabQ2[i] = new ArrayQueue();
    cheQ2[i] = new ArrayQueue();
  }
  
  //Prep stack
  //null pointer if put in draw
  rab_stack.push(1);
  rab_stack.push(2);
  che_stack.push(1);
  che_stack.push(2);
  che_stack.push(3);
}

void draw(){
  if(start && end == false) stage.startScreen();
  if(play1 || play2) stage.playScreen();
  if(record1 && start == false) stage.recordScreen1();
  if(record2 && start == false) stage.recordScreen2();
  if(model && start == false) stage.modelWalk();
  if(tree && start == false) stage.displayTree();
  if(end) stage.endScreen();
  //debug();
}

//need this to be declared here else if key hold and C/R moves
void keyPressed(){
  //>--------------------Play Screen-------------------<//
  
  //check whose turn it is and turn end if 2 steps taken
  if(rabbitTurn == true && rab_stack.size() <= 2) rabbit.turn();
  if(cheetahTurn == true && che_stack.size() <= 3) cheetah.turn();
  
  //>-----------------User Input method-----------------<//
  
  // If the return key is pressed, save the String and clear it
  if(key == '\n'){
    letter = typing;
    typing = ""; //clear the string
  } else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
  }
}
