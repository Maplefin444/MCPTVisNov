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
String getLocation(JSONObject list, String character){
  return list.getJSONObject(character).getString("location");
}
String getLink(JSONObject list, String character){
  return list.getJSONObject(character).getString("link");
}