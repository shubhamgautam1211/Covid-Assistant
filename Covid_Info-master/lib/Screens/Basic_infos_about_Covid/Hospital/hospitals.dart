import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_infos/DataFetching/hospitalbeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class hospital extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  hospital({this.prefsnewtrial});
  @override
  _hospitalState createState() => _hospitalState();
}

class _hospitalState extends State<hospital> {
  List circle=["https://img.icons8.com/ios/452/city.png","https://cdn0.iconfinder.com/data/icons/ecology-hazel-vol-1/256/Green-city-512.png"
    ,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcxhYXqpC9_L48TRQqcEBBZn9xrIU8Q1MrAQ&usqp=CAU",
    "https://cdn.iconscout.com/icon/free/png-256/smart-city-2641977-2189914.png",
    "https://www.pngjoy.com/pngm/129/2616373_city-icon-blockchain-for-cities-png-download.png"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Icon(Icons.arrow_back,size: 30,color: Colors.black,),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0,5,20,0),
          child: Text("Hospitals Count",style: TextStyle(fontFamily: "Bosk",fontSize: 30,color: Colors.black),),
        ),
      ),
      body: FutureBuilder(
        future: beds().beds1(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            var value = snapshot.data;
            var decodedJson = json.decode(value.body);
            String hospitalsstring=json.encode(decodedJson);
            widget.prefsnewtrial.setString("Hospitalssdata",hospitalsstring);
            return ListView.builder(
              itemCount: decodedJson["data"]["regional"].length-1,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    ExpansionTile(
                      leading: CachedNetworkImage(
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                        imageUrl: Link(index),
                      ),
                      title: Text(decodedJson["data"]["regional"][index]["state"],style: TextStyle(fontSize: 20),),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,30,30),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Rural Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["ruralHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Rural Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["ruralBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Urban Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["urbanHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Urban Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["urbanBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["totalHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Total Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  SizedBox(width: 10,),
                                  Text(decodedJson["data"]["regional"][index]["totalBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    color: safety(decodedJson["data"]["regional"][index]["totalBeds"]),
                                  ),
                                  SizedBox(width: 6,),
                                  Text(safety1(decodedJson["data"]["regional"][index]["totalBeds"])
                                    ,style: TextStyle(fontSize: 20,fontFamily: "Sergoeui",
                                    color: safety(decodedJson["data"]["regional"][index]["totalBeds"])),)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30,left: 70),
                      child: Divider(
                        thickness: 1,
                      ),
                    )
                  ],
                );
              },
            );
          }
          else{
            if(widget.prefsnewtrial.containsKey("Hospitalssdata")){
              final Hospitaldatastring = widget.prefsnewtrial.getString("Hospitalssdata");
              Map Hospitaldataconverted = json.decode(Hospitaldatastring);
              return ListView.builder(
                itemCount: Hospitaldataconverted["data"]["regional"].length-1,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      ExpansionTile(
                        leading: CachedNetworkImage(
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                          imageUrl: Link(index),
                        ),
                        title: Text(Hospitaldataconverted["data"]["regional"][index]["state"],style: TextStyle(fontSize: 20),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,10,30,30),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Rural Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["ruralHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Rural Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["ruralBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Urban Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["urbanHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Urban Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["urbanBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Total Hospitals:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["totalHospitals"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Total Beds:",style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                    SizedBox(width: 10,),
                                    Text(Hospitaldataconverted["data"]["regional"][index]["totalBeds"].toString(),style: TextStyle(fontSize: 22,fontFamily: "Helvetica"),),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      color: safety(Hospitaldataconverted["data"]["regional"][index]["totalBeds"]),
                                    ),
                                    SizedBox(width: 6,),
                                    Text(safety1(Hospitaldataconverted["data"]["regional"][index]["totalBeds"])
                                      ,style: TextStyle(fontSize: 20,fontFamily: "Sergoeui",
                                          color: safety(Hospitaldataconverted["data"]["regional"][index]["totalBeds"])),)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30,left: 70),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    ],
                  );
                },
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
      ),
    );

  }
  Color safety(int avlbl){
    if (avlbl<10000)
      return Colors.red[800];
    if (avlbl>10000 && avlbl<30000)
      return Colors.deepOrange;
    if (avlbl>30000 && avlbl<70000)
      return Colors.blue;
    if (avlbl>70000 && avlbl<100000)
      return Colors.green;

  }
  String safety1(int avlbl){
    if (avlbl<10000)
      return "Danger";
    if (avlbl>10000 && avlbl<30000)
      return "Average";
    if (avlbl>30000 && avlbl<70000)
      return "Safe";
    if (avlbl>70000 && avlbl<100000)
      return "Very Safe";
  }
  String Link(int index){
    if (index%4==0){
      return circle[0];
    }
    if (index%4==1){
      return circle[1];
    }
    if (index%4==2){
      return circle[2];
    }
    if (index%4==3){
      return circle[3];
    }
  }
}
