import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_infos/DataFetching/Contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class contacts extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  contacts({this.prefsnewtrial});
  @override
  _contactsState createState() => _contactsState();
}

class _contactsState extends State<contacts> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
        title: Text("Emergency Contact",style: TextStyle(fontFamily: "Bosk",fontSize: 30,color: Colors.brown),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: contactsno().contactno(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            var value = snapshot.data;
            var decodedJson = json.decode(value.body);
            String contactsstring=json.encode(decodedJson);
            widget.prefsnewtrial.setString("Contactsdata",contactsstring);
            return ListView.builder(
              itemCount: decodedJson["data"]["contacts"]["regional"].length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    _makePhoneCall("tel:"+"${decodedJson["data"]["contacts"]["regional"][index]["number"].toString()}");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Google_Contacts_icon.svg/1200px-Google_Contacts_icon.svg.png"),
                          ),
                          title: Text(decodedJson["data"]["contacts"]["regional"][index]["loc"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(decodedJson["data"]["contacts"]["regional"][index]["number"].toString(),style: TextStyle(fontSize: 15),),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                            child: Icon(Icons.call,color:Colors.green,size: 25,),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30,left: 70),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          else{
            if (widget.prefsnewtrial.containsKey("Contactsdata")){
              final contactdatastring = widget.prefsnewtrial.getString("Contactsdata");
              Map Countrydataconverted = json.decode(contactdatastring);
              return ListView.builder(
                itemCount: Countrydataconverted["data"]["contacts"]["regional"].length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      _makePhoneCall("tel:"+"${Countrydataconverted["data"]["contacts"]["regional"][index]["number"].toString()}");
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: CachedNetworkImage(
                                  imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Google_Contacts_icon.svg/1200px-Google_Contacts_icon.svg.png"
                              ),
                            ),
                            title: Text(Countrydataconverted["data"]["contacts"]["regional"][index]["loc"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(Countrydataconverted["data"]["contacts"]["regional"][index]["number"].toString(),style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,10,0),
                              child: Icon(Icons.call,color:Colors.green,size: 25,),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30,left: 70),
                          child: Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            else {
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
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
