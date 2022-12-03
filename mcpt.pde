int dialoguenum = 0;
String curDialogue = "";
String curSpeaker = "";
JSONObject current;
void setup(){
  size(900,600);
  current = loadJSONObject("dialogue1.json");
}


void draw(){
  clear();
  textSize(50);
  text(curSpeaker,100,100);
  text(curDialogue,100,200);
}

void mouseClicked(){
  if(dialoguenum < getDialogueLength(current)){
    curDialogue = getDialogue(current,dialoguenum);
    curSpeaker = getSpeaker(current,dialoguenum);
    dialoguenum++;
  }
  else{
    JSONArray arr = getSuccessors(current);
    if(arr.size() == 0) return;
    current = loadJSONObject(arr.getString(0));
    dialoguenum = 0;
  }
}

int getDialogueLength(JSONObject obj){
  return obj.getJSONArray("data").size();
}
String getDialogue(JSONObject obj, int index){
  return obj.getJSONArray("data").getJSONObject(index).getString("dialogue");
}
String getSpeaker(JSONObject obj, int index){
  return obj.getJSONArray("data").getJSONObject(index).getString("speaker");
}
JSONArray getSuccessors(JSONObject obj){
  return obj.getJSONArray("successors");
}
JSONArray getOptions(JSONObject obj){
  return obj.getJSONArray("options");
}
