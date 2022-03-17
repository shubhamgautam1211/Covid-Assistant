import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class dateslot extends StatefulWidget {
  Map<dynamic,dynamic> slot;
  dateslot({this.slot});
  @override
  _dateslotState createState() => _dateslotState(slot:slot);
}

class _dateslotState extends State<dateslot> {
  Map<dynamic,dynamic> slot;
  _dateslotState({this.slot});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,0),
        child: Center(
          child: ListView.builder(
              itemCount: slot["sessions"].length,
              itemBuilder: (context,index){
                return Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor: Colors.grey[300],
                                  scrollable: true,
                                  title: Padding(
                                    padding: const EdgeInsets.fromLTRB(60,0,0,0),
                                    child: Text('Slot Booking',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                                  ),
                                  content: Container(
                                    height: 150.0,
                                    width: 400.0,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: slot["sessions"][index]["slots"].length,
                                      itemBuilder: (BuildContext context, int index1) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(slot["sessions"][index]["slots"][index1],style: TextStyle(fontSize: 18),),
                                              onTap: (){
                                                _launchURL();
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(30,0,10,0),
                                              child: Divider(
                                                thickness: 1,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(170,0,15,25),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              onTap:(){
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK",style: TextStyle(fontSize: 19,color: Colors.blue,fontWeight: FontWeight.w500),)),
                                          SizedBox(width: 15,),
                                          GestureDetector(
                                              onTap:(){
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel",style: TextStyle(fontSize: 19,color: Colors.red,fontWeight: FontWeight.w500),)),

                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
                          height: 60,
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.fromLTRB(5,0,0,0),
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.network("https://freesvg.org/img/roystonlodge_Desk_Calendar.png",scale: 4,),
                              ),
                            ),
                            title: Text(slot["sessions"][index]["date"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            subtitle: Text("From-:${slot["from"]}  To-:${slot["to"]}"),
                            trailing: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,10,0),
                              child: Text("Min Age: "+slot["sessions"][index]["min_age_limit"].toString()),
                            ),
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
              }),
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://selfregistration.cowin.gov.in/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
