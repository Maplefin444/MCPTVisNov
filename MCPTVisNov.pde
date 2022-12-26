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
boolean namemode = true;
String name = "";
color filler = #606c81;
color stroke = #393457;
color hover = #4c586d;
color text = #cedaef;

void setup() {
    size(900,600);
    font = createFont("roman.ttf",30);
    textFont(font);
    frameRate(60);
    current = loadJSONObject("dialogue1.json");
    textAlign(LEFT,BASELINE);
}


void draw() {
    if (namemode) {
        background(filler);
        fill(text);
        textAlign(CENTER,CENTER);
        textSize(50);
        text("What's your name?" ,width / 2,(height / 2) - 85);
        text(name,width / 2,height / 2);
        strokeWeight(1);
        stroke(text);
        fill(text);
        line(textWidth(name)/2 + 450, height / 2 - 20, textWidth(name)/2 + 450, height / 2 + 30);
        textAlign(LEFT,BASELINE);
    }
    else {
        if (frames <= 60) frames++;
        else frames = 0;
        if (frames % 2 == 0 && rollCounter < getDialogue(current,dialoguenum).length()) rollCounter++;
        curDialogue = getDialogue(current,dialoguenum).substring(0,rollCounter);
        curSpeaker = getSpeaker(current,dialoguenum);
        drawCharacter();
        if (!choice) {
            fill(filler);
            strokeWeight(10);
            stroke(stroke);
            rect(50,350,200,50,12);
            rect(50,400,800,150,12);
            fill(text);
            textSize(30);
            text(curSpeaker,70,385);
            textSize(20);
            text(curDialogue,70,412,760,120);
            noStroke();
        }
        else{
            textAlign(CENTER,CENTER);
            if (currentoptions.size() == 2) {
                drawOption(100,175,700,100);
                drawOption(100,300,700,100);
                fill(text);
                textSize(25);
                text(currentoptions.getString(0),105,175,680,100);
                text(currentoptions.getString(1),105,300,680,100);
            }
            if (currentoptions.size() == 3) {
                fill(255,255,255);
                drawOption(100,125,700,100);
                drawOption(100,250,700,100);
                drawOption(100,375,700,100);
                fill(text);
                textSize(25);
                text(currentoptions.getString(0),105,125,680,100);
                text(currentoptions.getString(1),105,250,680,100);
                text(currentoptions.getString(2),105,375,680,100);
            }
            if (currentoptions.size() == 4) {
                fill(255,255,255);
                drawOption(100,50,700,100);
                drawOption(100,175,700,100);
                drawOption(100,300,700,100);
                drawOption(100,425,700,100);
                fill(text);
                textSize(25);
                text(currentoptions.getString(0),105,50,680,100);
                text(currentoptions.getString(1),105,175,680,100);
                text(currentoptions.getString(2),105,300,680,100);
                text(currentoptions.getString(3),105,425,680,100);
            }
            if (currentoptions.size() > 4) {
                print("currently not supported!");
                throw new IllegalArgumentException();
            }
            textAlign(LEFT,BASELINE);
        }
        
    }
}

void mouseClicked() {
    if (!namemode) {
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
                if (checkMouse(100,125,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(0));
                    nextDialogue();
                    choice = false;
                }
                if (checkMouse(100,250,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(1));
                    nextDialogue();
                    choice = false;
                }
                if (checkMouse(100,375,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(2));
                    nextDialogue();
                    choice = false;
                }
            }
            if (currentoptions.size() == 4) {
                if (checkMouse(100,50,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(0));
                    nextDialogue();
                    choice = false;
                }
                if (checkMouse(100,175,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(1));
                    nextDialogue();
                    choice = false;
                }
                if (checkMouse(100,300,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(2));
                    nextDialogue();
                    choice = false;
                }
                if (checkMouse(100,425,700,100)) {
                    current = loadJSONObject(currentsuccessors.getString(3));
                    nextDialogue();
                    choice = false;
                }
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
}

void keyPressed() {
    if (namemode) {
        if (key == BACKSPACE) {
            if (name.length() > 0) name = name.substring(0,name.length() - 1);
        }
        else if (key ==  RETURN || key ==  ENTER) {
            if (name.length() > 0) namemode = false;
        }
        else if (key == CODED) return;
        else if (name.length() < 20) {
            name += key;
        }
    }
}

void drawCharacter() {
    if (!drawn) {
        PImage bg = loadImage("Game_Jam_bg.png");
        bg.resize(900, 600);
        image(bg, 0, 0);
        //background(bg);
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

String replaceName(String str) {
    return str.replace("[NAME]",name);
}

void drawOption(int x, int y, int w, int h) {
    fill(filler);
    strokeWeight(10);
    stroke(stroke);
    if (checkMouse(x,y,w,h))fill(hover);
    rect(x,y,w,h,12);
    noStroke();
}