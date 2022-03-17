String converteddate(List<dynamic> monthsinwords, decodedJson, int j) {

    String date;
    String updateddate;
    String newdate;
    if (decodedJson["data"][j]["day"][5] == "0") {
      date = decodedJson["data"][j]["day"][6];
    }
    else {
      date =
          decodedJson["data"][j]["day"][5] + decodedJson["data"][j]["day"][6];
    }
    for (int i = 1; i <= monthsinwords.length; i++) {
      if (date == i.toString()) {
        updateddate = monthsinwords[i - 1];
      }
    }
    if (decodedJson["data"][j]["day"][8] == "0") {
      newdate = updateddate + decodedJson["data"][j]["day"][9] +
          decodedJson["data"][j]["day"][0]
          + decodedJson["data"][j]["day"][1] +
          decodedJson["data"][j]["day"][2] + decodedJson["data"][j]["day"][3];
    }
    else {
      newdate = updateddate + decodedJson["data"][j]["day"][8] +
          decodedJson["data"][j]["day"][9] +
          decodedJson["data"][j]["day"][0]
          + decodedJson["data"][j]["day"][1] +
          decodedJson["data"][j]["day"][2] + decodedJson["data"][j]["day"][3];
    }
    return newdate;

}

String Converteddata1(String date1){
  List monthsinwords=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  List monthsinnumbers=["01","02","03","04","05","06","07","08","09","10","11","12"];
  String monthupdate,dateupdate;
  String month = date1[0]+date1[1]+date1[2];
  for (int i=0;i<monthsinwords.length;i++){
    if (month==monthsinwords[i]){
      monthupdate=monthsinnumbers[i];
    }
  }
  if (date1.length==8){
    dateupdate="0"+date1[3];
  }
  else{
    dateupdate=date1[3]+date1[4];
  }
  String finaldate;
  if (date1.length==8){
    finaldate = dateupdate+"-"+monthupdate+"-"+date1[4]+date1[5]+date1[6]+date1[7];
  }
  if (date1.length==9){
    finaldate = dateupdate+"-"+monthupdate+"-"+date1[5]+date1[6]+date1[7]+date1[8];
  }
  return finaldate;
}