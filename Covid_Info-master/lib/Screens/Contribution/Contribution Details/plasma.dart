import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class plasma extends StatefulWidget {
  @override
  _plasmaState createState() => _plasmaState();
}

class _plasmaState extends State<plasma> {
  List monthsinwords=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  String month;
  DatabaseReference ref1 = FirebaseDatabase.instance
      .reference()
      .child("Details")
      .child("Info about Plasma avlbl");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ref1.onValue,
          builder: (context, snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              List item = [];
              data.forEach((index, data) => item.add({"key": index, ...data}));
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ExpansionTile(
                          leading: CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item[index]["NAME"],
                            style: TextStyle(fontSize: 20),
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20,0,10,5),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(item[index]["Time"],style: TextStyle(fontSize: 18),)
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(

                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.place,),
                                                  Container(
                                                      width: 140,
                                                      child: Text(item[index]["City"],style: TextStyle(fontSize: 18),))
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                            child: Text(monthsinwords[item[index]["Month"]-1]+"-"+item[index]["Date"],
                                              style: TextStyle(fontSize: 18),),
                                          )
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height:20,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone No:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Helvetica"),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            _makePhoneCall("tel:"+"${item[index]["Phone"]}");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(3,0,0,0),
                                            child: Text(
                                              item[index]["Phone"],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Alt Phone:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Helvetica"),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            _makePhoneCall("tel:"+"${item[index]["Alt Phone"]}");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(3,0,0,0),
                                            child: Text(
                                              item[index]["Alt Phone"],
                                              style: TextStyle(
                                                fontSize: 20,
                                                  decoration: TextDecoration.underline,
                                                  color: Colors.blue
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(1,0,0,0),
                                                    child: Text(
                                                      "Address:",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            100, 2, 0, 0),
                                                    child: Container(
                                                        width: 220,
                                                        child: Text(
                                                          item[index]["Address"],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                  ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Text(
                                                    "Message:",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            100, 2, 0, 0),
                                                    child: Container(
                                                        width: 220,
                                                        child: Text(
                                                          item[index]["Message"],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ),
                                  Container(
//                                    color: Colors.green,
                                    height: 50,
                                    width: MediaQuery.of(context).size.width-50,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                      child: Container(
                                        child: item[index]["Verified"]=="True"? Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("Verified",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w600),),
                                            Icon(Icons.verified,color: Colors.green,)
                                          ],
                                        ):
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("Not Verified",style: TextStyle(color: Colors.red[500],fontSize: 16,fontWeight: FontWeight.w600),),
                                            Icon(Icons.cancel,color: Colors.red[500],)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
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
          }),
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
