import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class twittersearch extends StatefulWidget {
  @override
  _twittersearchState createState() => _twittersearchState();
}

class _twittersearchState extends State<twittersearch> {
  String city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(("Twitter Search For COVID"),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Colors.black),),
              Text(("Find latest resources on Twitter"),style: TextStyle(color: Colors.grey[500],fontSize: 20),),
              SizedBox(height: 30,),
              Text(("Enter Area/Region"),style: TextStyle(fontFamily: "Sergoeui",fontSize: 30,color: Colors.black,fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.fromLTRB(20,20,20,0),
                child: Container(
                  child: TextField(
                    style: TextStyle(fontSize: 25,color: Colors.black),
                    decoration: InputDecoration(
                      labelText: ("Enter City"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city,size: 30,color: Colors.black,),
                      filled: false,
                    ),
                    onChanged: (text){
                      city=text;
                    },

                  ),

                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,0),
                  child: RaisedButton(
                    color: Colors.redAccent,
                    elevation: 5,
                    onPressed: (){
                      String url="https://twitter.com/search?q=verified+${city}+(bed+OR+beds+OR+icu+OR+oxygen+OR+ventilator+OR+ventilators+OR+fabiflu)+-%22not+verified%22+-%22unverified%22+-%22needed%22+-%22required%22&f=live";
                      _launchURL(url);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Text("Search",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
