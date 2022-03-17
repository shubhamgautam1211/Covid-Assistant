import 'package:flutter/foundation.dart';

class onsearch extends ChangeNotifier{
  int searched=-1;
  int c=0,index;
  bool searchpressed=false;

  int countryfound1(){
    return searched;
  }

  countryfound(int i){
    searched=i;
    notifyListeners();
  }

  searchclear(){
    searched=-1;
    notifyListeners();
  }

  update(int j){
    c=1;
    index=j;
    notifyListeners();
  }

  int updatedC(){
    return c;
  }

  onpresssearch(){
    searchpressed=true;
    notifyListeners();
  }
  offpresssearch(){
    searchpressed=false;
    notifyListeners();
  }
  int updatedindex(){
    return index;
  }

  bool updatesearch(){
    return searchpressed;
  }


}