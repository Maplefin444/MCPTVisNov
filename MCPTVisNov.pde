int dialoguenum = 0;
String curDialogue = "";
String curSpeaker = "";
JSONObject current;
int frames = 0;
int rollCounter = 0;
PFont font;
void setup() {
    size(900,600);
    font = createFont("roman.ttf",30);
    textFont(font);
    frameRate(60);
    current = loadJSONObject("dialogue1.json");
}


void draw() {
    if (frames <= 60) frames++;
    else frames = 0;
    if(frames % 3 == 0 && rollCounter < getDialogue(current,dialoguenum).length()) rollCounter++;
    curDialogue = getDialogue(current,dialoguenum).substring(0,rollCounter);
    curSpeaker = getSpeaker(current,dialoguenum);
    background(127,127,127);
    fill(255,255,255);
    rect(50,400,800,150);
    fill(0,0,0);
    textSize(30);
    text(curSpeaker,100,350);
    text(curDialogue,100,450);

}

void mouseClicked() {
    if (dialoguenum < getDialogueLength(current) - 1) {
        rollCounter = 0;
        dialoguenum++;
    }
    else{
        JSONArray arr = getSuccessors(current);
        if (arr.size() == 0) return;
        rollCounter = 0;
        current = loadJSONObject(arr.getString(0));
        dialoguenum = 0;
    }
}


