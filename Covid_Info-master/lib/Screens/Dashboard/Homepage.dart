import 'dart:convert';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/Contacts.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/Vaccine.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/basicinfo.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/funding.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/govtinfo.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/twittersearch.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/Hospital/hospitals.dart';
import 'package:covid_infos/DataFetching/Worlddata.dart';
import 'package:covid_infos/Screens/Contribution/contributionbody.dart';
import 'package:covid_infos/Screens/Covidcases/CountryWise.dart';
import 'package:covid_infos/Screens/Covidcases/statewise.dart';
import 'package:covid_infos/Services/totalsample.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  homepage({this.prefsnewtrial});
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  List<Map<dynamic, dynamic>> worldstats = [
    {
      "text1": "TOTAL Case",
      "text2": "cases",
      "color": Colors.blueAccent,
      "image": "Assets/Images/covidBlue.png"
    },
    {
      "text1": "TOTAL Death",
      "text2": "deaths",
      "color": Color.fromRGBO(220,28,49,1),
      "image": "Assets/Images/death.png"
    },
    {
      "text1": "TOTAL Recovery",
      "text2": "recovered",
      "color": Color.fromRGBO(10,190,60,1),
      "image": "Assets/Images/recover.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var breadth=MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: worlddata().world(),
      builder: (context,snapshot){
        if (snapshot.hasData){
          var value = snapshot.data;
          var decodedJson = json.decode(value.body);
          widget.prefsnewtrial.setInt("HomeGlobalTotalcase",decodedJson[worldstats[0]["text2"]]);
          widget.prefsnewtrial.setInt("HomeGlobalTotalDeath",decodedJson[worldstats[1]["text2"]]);
          widget.prefsnewtrial.setInt("HomeGlobalTotalRecovery",decodedJson[worldstats[2]["text2"]]);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset("Assets/Images/personFighting.png",
                          fit: BoxFit.cover,),
                    ),
                  ),
                  SliverList(delegate: SliverChildListDelegate([
                    Container(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(25,10,0,0),
                                child: Text("Global Covid-19",
                                  style: TextStyle(fontSize: 35,fontFamily: "Sergoeui",
                                      fontWeight: FontWeight.bold
                                  )
                                )
                              )
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 130,
                            width: breadth-30,
                            child: PageView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return Container(
                                      height: 130,
                                      margin: EdgeInsets.fromLTRB(10,0,10,0),
                                      decoration: BoxDecoration(
                                          color: worldstats[index]["color"],
                                          border: Border.all(
                                            color: worldstats[index]["color"],
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20,40,0,0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(worldstats[index]["text1"],style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),),
                                                Text(decodedJson[worldstats[index]["text2"]].toString(),style: TextStyle(fontSize: 23,color: Colors.white),)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: index<2?EdgeInsets.fromLTRB(80,0,0,0):EdgeInsets.fromLTRB(50,0,0,0),
                                            child: Image.asset(worldstats[index]["image"],scale: 1.5,),
                                          )
                                        ],
                                      )
                                  );
                                }),
                          ),
                          SizedBox(height: 20,),
                          Text("ADDITIONAL INFOS",style: GoogleFonts.slabo27px(
                            textStyle: TextStyle(color: Colors.red,fontSize: 35,fontWeight: FontWeight.w600),
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => hospital(prefsnewtrial:widget.prefsnewtrial)));
                                },
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
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.local_hospital_outlined,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Hospitals",style: TextStyle(fontFamily: "Helvetica",color: Colors.white
                                                  ,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => govtinfo()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => vaccine()));
                                    },
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
                                                colors: [Color(0xFF141e30),Color(0xFF243b55)]),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        height: 140,
                                        width: 180,
                                        child: Center(
                                            child:
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                  child: Icon(Icons.local_hospital_outlined,size: 30,color: Colors.white,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                                  child: Text("Vaccine Avlbl",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => twittersearch()));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.phone_android,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Twitter Search",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CrowdFunding()));
                                },
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
                                            colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.money,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Donations",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => statewise(prefsnewtrial : widget.prefsnewtrial)));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.phone_android,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Daily Stats",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => contacts(prefsnewtrial:widget.prefsnewtrial)));
                                },
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
                                            colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.money,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Contact",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => totalsample()));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 220,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.people,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Sample Tested",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),

                    ),

                  ]))
                ],

              ),
            ),
          );
        }
        else{
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset("Assets/Images/personFighting.png",
                        fit: BoxFit.cover,),
                    ),
                  ),
                  SliverList(delegate: SliverChildListDelegate([
                    Container(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(25,10,0,0),
                                child: Text("Global Covid-19",style: TextStyle(fontSize: 35,fontFamily: "Sergoeui",fontWeight: FontWeight.bold),),
                              )),
                          SizedBox(height: 15,),
                          Container(
                            height: 130,
                            width: breadth-30,
                            child: PageView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return Container(
                                      height: 130,
                                      margin: EdgeInsets.fromLTRB(10,0,10,0),
                                      decoration: BoxDecoration(
                                          color: worldstats[index]["color"],
                                          border: Border.all(
                                            color: worldstats[index]["color"],
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20,40,0,0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(worldstats[index]["text1"],style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),),
                                                Text(index==0?widget.prefsnewtrial.getInt("HomeGlobalTotalcase").toString():index==1
                                                    ? widget.prefsnewtrial.getInt("HomeGlobalTotalDeath").toString()
                                                    : widget.prefsnewtrial.getInt("HomeGlobalTotalRecovery").toString(),style: TextStyle(fontSize: 23,color: Colors.white),)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: index<2?EdgeInsets.fromLTRB(80,0,0,0):EdgeInsets.fromLTRB(50,0,0,0),
                                            child: Image.asset(worldstats[index]["image"],scale: 1.5,),
                                          )
                                        ],
                                      )
                                  );
                                }),
                          ),
                          SizedBox(height: 20,),
                          Text("ADDITIONAL INFOS",style: GoogleFonts.slabo27px(
                            textStyle: TextStyle(color: Colors.red,fontSize: 35,fontWeight: FontWeight.w600),
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => hospital(prefsnewtrial:widget.prefsnewtrial)));
                                },
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
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.local_hospital_outlined,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Hospitals",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => govtinfo()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5,2,2,2),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => vaccine()));
                                    },
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
                                                colors: [Color(0xFF141e30),Color(0xFF243b55)]),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        height: 140,
                                        width: 180,
                                        child: Center(
                                            child:
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                  child: Icon(Icons.local_hospital_outlined,size: 30,color: Colors.white,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                                  child: Text("Vaccine Avlbl",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => twittersearch()));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.phone_android,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Twitter Search",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CrowdFunding()));
                                },
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
                                            colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.money,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Donations",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => statewise(prefsnewtrial: widget.prefsnewtrial,)));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.phone_android,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Daily Stats",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => contacts(prefsnewtrial:widget.prefsnewtrial)));
                                },
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
                                            colors: [Color(0xFFeb3349),Color(0xFFf45c43)]),
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 180,
                                    child: Center(
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                              child: Icon(Icons.money,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,0,0),
                                              child: Text("Contacts",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),

                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => totalsample()));
                                },
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
                                            colors: [Color(0xFF06beb6),Color(0xFF48b1bf)]),
                                        border: Border.all(
                                          color: Colors.black
                                          ,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: 140,
                                    width: 220,
                                    child: Center(
                                        child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Icon(Icons.people,size: 30,color: Colors.white,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                              child: Text("Sample Tested",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                            ),                                    ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),

                    ),

                  ]))
                ],

              ),
            ),
          );
        }
      },
    );

  }
}
