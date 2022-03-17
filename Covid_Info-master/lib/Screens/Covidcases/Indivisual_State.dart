import 'dart:convert';
import 'package:covid_infos/DataFetching/indivisual_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';


class indivisualstate extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  int index;
  List logo;
  List dailydata;
  indivisualstate({this.prefsnewtrial,this.index,this.logo,this.dailydata});
  @override
  _indivisualstateState createState() => _indivisualstateState(index:index,logo:logo,dailydata:dailydata);
}

class _indivisualstateState extends State<indivisualstate> {
  int index,currentPage;
  List dailydata,logo;
  SharedPreferences prefs;
  var var1,eventdirection;

  _indivisualstateState({this.index,this.logo,this.dailydata});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage=index;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: statedata().statedata1(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var value = snapshot.data;
          var decodedjson = json.decode(value.body);
          String indivisualstatesdatastring=json.encode(decodedjson);
          widget.prefsnewtrial.setString("indivisualstatesdatastring",indivisualstatesdatastring);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Listener(
                      onPointerMove: (moveEvent){
                        setState(() {
                          eventdirection=moveEvent;
                        });
                      },
                      child: PageView.builder(
                        itemCount: 36,
//                        physics: RightBlockedScrollPhysics(),
                        onPageChanged: (value) => {
                          setState(() => {
                            if(eventdirection.delta.dx < 0) {
                              currentPage==35?currentPage=0:currentPage = currentPage+1,
                            },
                            if(eventdirection.delta.dx > 0) {
                              currentPage==0?currentPage=35:currentPage = currentPage-1,
                            },
                          })
                        },
                        itemBuilder: (context,index1){
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                child: Text(logo[currentPage],style: TextStyle(fontSize:50,fontWeight: FontWeight.w500),),
                              ),
                              SizedBox(height: 10,),
                              decodedjson["data"]["regional"][currentPage]["loc"].length>20?
                              Text(decodedjson["data"]["regional"][currentPage]["loc"],
                                style: TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.w600),):
                              Text(decodedjson["data"]["regional"][currentPage]["loc"],
                                style: TextStyle(fontSize:35,color: Colors.black,fontWeight: FontWeight.w600),),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height-200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: 15,
                                  spreadRadius: -1)
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0)
                            ),

                          ),
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context,index1){
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,20,0,0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color(0xFF2193b0),Color(0xFF6dd5ed)]),

                                                  border: Border.all(
                                                    color: Colors.blueAccent,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("TL Cases",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      Text(decodedjson["data"]["regional"][currentPage]["totalConfirmed"].toString(),style: TextStyle(color: Colors.white,fontSize: 23),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                            child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomRight,
                                                        end: Alignment.topLeft,
                                                        colors: [Color(0xFF02aab0),Color(0xFF00cdac)]),

                                                    border: Border.all(
                                                      color: Color.fromRGBO(10,190,60,1),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                height: 140,
                                                width: 160,
                                                child: Center(
                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Foreign",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                        Text(decodedjson["data"]["regional"][currentPage]["confirmedCasesForeign"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                border: Border.all(
                                                  color: Color.fromRGBO(220,28,49,1),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                            height: 140,
                                            width: 160,
                                            child: Center(
                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Recovered",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                    Text(decodedjson["data"]["regional"][currentPage]["discharged"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                          child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.bottomRight,
                                                      end: Alignment.topLeft,
                                                      colors: [Color(0xFF614385),Color(0xFF516395)]),

                                                  border: Border.all(
                                                    color: Colors.deepPurpleAccent,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Total Death",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      Text(decodedjson["data"]["regional"][currentPage]["deaths"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text("${dailydata[dailydata.length-1][0].toString()} Updates",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                border: Border.all(
                                                  color: Color.fromRGBO(220,28,49,1),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                            height: 140,
                                            width: 160,
                                            child: Center(
                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Today +ve",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                    currentPage+4>=12?Text(dailydata[dailydata.length-3][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),):
                                                    Text(dailydata[dailydata.length-3][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                          child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.bottomRight,
                                                      end: Alignment.topLeft,
                                                      colors: [Color(0xFF614385),Color(0xFF516395)]),

                                                  border: Border.all(
                                                    color: Colors.deepPurpleAccent,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Today Rcvd",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      currentPage+4>=12?Text(dailydata[dailydata.length-2][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),):
                                                      Text(dailydata[dailydata.length-2][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                border: Border.all(
                                                  color: Color.fromRGBO(220,28,49,1),
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                            ),
                                            height: 140,
                                            width: 160,
                                            child: Center(
                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Today Death",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                    currentPage+4>=12?Text(dailydata[dailydata.length-1][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),)
                                                        : Text(dailydata[dailydata.length-1][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 140,),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        }
        else{
          if(widget.prefsnewtrial.containsKey("indivisualstatesdatastring")==true){
            final yourSindivisualstate = widget.prefsnewtrial.getString("indivisualstatesdatastring");
            Map indivisualStatedata=json.decode(yourSindivisualstate);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Listener(
                        onPointerMove: (moveEvent){
                          setState(() {
                            eventdirection=moveEvent;
                          });
                        },
                        child: PageView.builder(
                          itemCount: 36,
//                        physics: RightBlockedScrollPhysics(),
                          onPageChanged: (value) => {
                            setState(() => {
                              if(eventdirection.delta.dx < 0) {
                                currentPage==35?currentPage=0:currentPage = currentPage+1,
                              },
                              if(eventdirection.delta.dx > 0) {
                                currentPage==0?currentPage=35:currentPage = currentPage-1,
                              },
                            })
                          },
                          itemBuilder: (context,index1){
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  child: Text(logo[currentPage],style: TextStyle(fontSize:50,fontWeight: FontWeight.w500),),
                                ),
                                SizedBox(height: 10,),
                                indivisualStatedata["data"]["regional"][currentPage]["loc"].length>20?
                                Text(indivisualStatedata["data"]["regional"][currentPage]["loc"],
                                  style: TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.w600),):
                                Text(indivisualStatedata["data"]["regional"][currentPage]["loc"],
                                  style: TextStyle(fontSize:35,color: Colors.black,fontWeight: FontWeight.w600),),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height-200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 15,
                                    spreadRadius: -1)
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)
                              ),

                            ),
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context,index1){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0,20,0,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [Color(0xFF2193b0),Color(0xFF6dd5ed)]),

                                                    border: Border.all(
                                                      color: Colors.blueAccent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                height: 140,
                                                width: 160,
                                                child: Center(
                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("TL Cases",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                        Text(indivisualStatedata["data"]["regional"][currentPage]["totalConfirmed"].toString(),style: TextStyle(color: Colors.white,fontSize: 23),),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                              child: Card(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment.bottomRight,
                                                          end: Alignment.topLeft,
                                                          colors: [Color(0xFF02aab0),Color(0xFF00cdac)]),

                                                      border: Border.all(
                                                        color: Color.fromRGBO(10,190,60,1),
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: 140,
                                                  width: 160,
                                                  child: Center(
                                                      child:
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Foreign",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                          Text(indivisualStatedata["data"]["regional"][currentPage]["confirmedCasesForeign"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(220,28,49,1),
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Recovered",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      Text(indivisualStatedata["data"]["regional"][currentPage]["discharged"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                            child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomRight,
                                                        end: Alignment.topLeft,
                                                        colors: [Color(0xFF614385),Color(0xFF516395)]),

                                                    border: Border.all(
                                                      color: Colors.deepPurpleAccent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                height: 140,
                                                width: 160,
                                                child: Center(
                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Total Death",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                        Text(indivisualStatedata["data"]["regional"][currentPage]["deaths"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Text("${dailydata[dailydata.length-1][0].toString()} Updates",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(220,28,49,1),
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Today +ve",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      currentPage+4>=12?Text(dailydata[dailydata.length-3][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),):
                                                      Text(dailydata[dailydata.length-3][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                            child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomRight,
                                                        end: Alignment.topLeft,
                                                        colors: [Color(0xFF614385),Color(0xFF516395)]),

                                                    border: Border.all(
                                                      color: Colors.deepPurpleAccent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                height: 140,
                                                width: 160,
                                                child: Center(
                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Today Rcvd",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                        currentPage+4>=12?Text(dailydata[dailydata.length-2][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),):
                                                        Text(dailydata[dailydata.length-2][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(220,28,49,1),
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              height: 140,
                                              width: 160,
                                              child: Center(
                                                  child:
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Today Death",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                                      currentPage+4>=12?Text(dailydata[dailydata.length-1][currentPage+4+1].toString(),style: TextStyle(color: Colors.white,fontSize: 20),)
                                                          : Text(dailydata[dailydata.length-1][currentPage+4].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 140,),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            );
          }
          else{
            return Scaffold(
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 300,
                            child: SvgPicture.asset("Assets/Images/no_data.svg")),
                        SizedBox(height: 35,),
                        Text("NO DATA FOUND",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                      ],
                    )
                )
            );
          }
        }
      },
    );
  }
}
