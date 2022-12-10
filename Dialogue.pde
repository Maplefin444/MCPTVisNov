int getDialogueLength(JSONObject obj) {
    return obj.getJSONArray("data").size();
}
String getDialogue(JSONObject obj, int index) {
    return obj.getJSONArray("data").getJSONObject(index).getString("dialogue");
}
String getSpeaker(JSONObject obj, int index) {
    return obj.getJSONArray("data").getJSONObject(index).getString("speaker");
}
JSONArray getSuccessors(JSONObject obj) {
    return obj.getJSONArray("successors");
}
JSONArray getOptions(JSONObject obj) {
    return obj.getJSONArray("options");
}
JSONObject getCharacter(JSONObject obj,String charname) {
    JSONArray array = obj.getJSONArray("characters");
    for (int i = 0; i < array.size();i++) {
        if (array.getJSONObject(i).getString("name").equals(charname)) return array.getJSONObject(i);
    }
    return null;
}
JSONArray getCharacterList(JSONObject obj) {
    return obj.getJSONArray("characters");
}