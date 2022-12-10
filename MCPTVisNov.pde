int dialoguenum = 0;
JSONObject charlist;
String curDialogue = "";
String curSpeaker = "";
JSONObject current;
int frames = 0;
int rollCounter = 0;
PFont font;
boolean drawn = false;

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
    if (frames % 2 == 0 && rollCounter < getDialogue(current,dialoguenum).length()) rollCounter++;
    curDialogue = getDialogue(current,dialoguenum).substring(0,rollCounter);
    curSpeaker = getSpeaker(current,dialoguenum);
    fill(255,255,255);
    rect(50,350,150,50);
    rect(50,400,800,150);
    drawCharacter();
    fill(0,0,0);
    textSize(30);
    text(curSpeaker,70,385);
    text(curDialogue,100,450);
}

void mouseClicked() {
    if (dialoguenum < getDialogueLength(current) - 1) {
        rollCounter = 0;
        drawn = false;
        dialoguenum++;
    }
    else{
        JSONArray arr = getSuccessors(current);
        if (arr.size() == 0) return;
        drawn = false;
        rollCounter = 0;
        current = loadJSONObject(arr.getString(0));
        dialoguenum = 0;
    }
}

void drawCharacter() {
    if (!drawn) {
        background(127,127,127);
        JSONArray list = getCharacterList(current);
        for (int i = 0; i < list.size();i++) {
            JSONObject object = list.getJSONObject(i);
            if (object.getString("name").equals(curSpeaker)) {
                noTint();
                image(loadImage(object.getString("link")),object.getInt("x"),object.getInt("y"),object.getInt("w"),object.getInt("h"));
            }
            else{
                tint(127,127,127);
                image(loadImage(object.getString("link")),object.getInt("x"),object.getInt("y"),object.getInt("w"),object.getInt("h"));
            }
        }
        drawn = true;
    }
}