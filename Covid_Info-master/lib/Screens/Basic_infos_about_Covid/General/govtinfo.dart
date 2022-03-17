import 'dart:convert';
import 'dart:io';
import 'package:covid_infos/DataFetching/Contacts.dart';
import 'package:covid_infos/DataFetching/govtdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
class govtinfo extends StatefulWidget {
  @override
  _govtinfoState createState() => _govtinfoState();
}

class _govtinfoState extends State<govtinfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: govt().govt1(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            var value = snapshot.data;
            var decodedJson = json.decode(value.body);
            return ListView.builder(
              itemCount: decodedJson["data"]["notifications"].length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: ()async{
                    String url1 = decodedJson["data"]["notifications"][index]["link"].toString();

                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Google_Contacts_icon.svg/1200px-Google_Contacts_icon.svg.png"),
                            ),
                            title: Text(decodedJson["data"]["notifications"][index]["title"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
            return Scaffold(
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitWave(color: Colors.black,size: 70,),
                        SizedBox(height: 20,),
                        Text("Initialising...",style: TextStyle(fontSize: 25),)
                      ],
                    )));
          }
        },
      ),
    );
  }

}
