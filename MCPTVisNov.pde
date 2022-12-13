int dialoguenum = 0;
JSONObject charlist;
String curDialogue = "";
String curSpeaker = "";
JSONObject current;
int frames = 0;
int rollCounter = 0;
PFont font;
boolean drawn = false;
JSONArray currentoptions;
JSONArray currentsuccessors;
boolean choice = false;

void setup() {
    size(900,600);
    font = createFont("roman.ttf",30);
    textFont(font);
    frameRate(60);
    current = loadJSONObject("dialogue1.json");
    textAlign(LEFT,BASELINE);
}


void draw() {
    if (frames <= 60) frames++;
    else frames = 0;
    if (frames % 2 == 0 && rollCounter < getDialogue(current,dialoguenum).length()) rollCounter++;
    curDialogue = getDialogue(current,dialoguenum).substring(0,rollCounter);
    curSpeaker = getSpeaker(current,dialoguenum);
    drawCharacter();
    if (!choice) {
        fill(255,255,255);
        rect(50,350,150,50);
        rect(50,400,800,150);
        fill(0,0,0);
        textSize(30);
        text(curSpeaker,70,385);
        text(curDialogue,100,450);
    }
    else{
        textAlign(CENTER,CENTER);
        if (currentoptions.size() == 2) {
            fill(255,255,255);
            if (checkMouse(100,175,700,100)) fill(200,200,200);
            rect(100,175,700,100);
            fill(255,255,255);
            if (checkMouse(100,300,700,100)) fill(200,200,200);
            rect(100,300,700,100);
            fill(0,0,0);
            textSize(25);
            text(currentoptions.getString(0),105,175,680,100);
            text(currentoptions.getString(1),105,300,680,100);
        }
        if (currentoptions.size() == 3) {
            fill(255,255,255);
            rect(100,125,700,100);
            rect(100,250,700,100);
            rect(100,375,700,100);
        }
        if (currentoptions.size() == 4) {
            fill(255,255,255);
            rect(100,50,700,100);
            rect(100,175,700,100);
            rect(100,300,700,100);
            rect(100,425,700,100);
        }
        if (currentoptions.size() > 4) {
            print("currently not supported!");
            throw new IllegalArgumentException();
        }
        textAlign(LEFT,BASELINE);
    }
    
}

void mouseClicked() {
    if (choice) {
        if (currentoptions.size() == 2) {
            if (checkMouse(100,175,700,100)) {
                current = loadJSONObject(currentsuccessors.getString(0));
                nextDialogue();
                choice = false;
            }
            if (checkMouse(100,300,700,100)) {
                current = loadJSONObject(currentsuccessors.getString(1));
                nextDialogue();
                choice = false;
                
            }
        }
        if (currentoptions.size() == 3) {
        }
        if (currentoptions.size() == 4) {
        }
    }
    else{
        if (dialoguenum < getDialogueLength(current) - 1) {
            rollCounter = 0;
            drawn = false;
            dialoguenum++;
        }
        else{
            JSONArray succ = getSuccessors(current);
            JSONArray opt = getOptions(current);
            if (succ.size() == 0) return;
            //ifthere is 1 successor and no options, go to next
            if (opt.size() == 0 && succ.size() == 1) {
                current = loadJSONObject(succ.getString(0));
                nextDialogue();
                return;
            }
            //ifthere are more options than successors or more successors than options
            if (opt.size() != succ.size()) throw new IllegalArgumentException();
            currentoptions = opt;
            currentsuccessors = succ;
            choice = true;
            drawn = false;
            
        }
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

boolean checkMouse(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= (x + w) && mouseY >= y && mouseY <= (y + h)) return true;
    return false;
}

void nextDialogue() {
    rollCounter = 0;
    dialoguenum = 0;
    drawn = false;
}