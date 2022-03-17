import 'package:covid_infos/Screens/Contribution/Contribution%20Details/hospital.dart';
import 'package:covid_infos/Screens/Contribution/Contribution%20Details/medicine.dart';
import 'package:covid_infos/Screens/Contribution/Contribution%20Details/oxygen.dart';
import 'package:covid_infos/Screens/Contribution/Contribution%20Details/plasma.dart';
import 'package:covid_infos/Screens/Contribution/contributionpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class contributionbody extends StatefulWidget {
  @override
  _contributionbodyState createState() => _contributionbodyState();
}

class _contributionbodyState extends State<contributionbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                  height: 200,
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: SvgPicture.asset("Assets/Images/mask-man.svg"),
                  )),
              Container(
                  width: 190,
                  child: Text("HELP ALL SAVE ALL",style: TextStyle(fontSize: 39,fontWeight: FontWeight.bold,),))
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => plasma()));
                  },
                  child: Card(
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
                      width: 180,
                      child: Center(
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.flag,size: 35,color: Colors.white,),
                              Text("Plasma",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                            ],
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,2,2,2),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => hosp()));
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
                                colors: [Color(0xFF02aab0),Color(0xFF00cdac)]),

                            border: Border.all(
                              color: Color.fromRGBO(10,190,60,1),
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
                                Icon(Icons.flag,size: 35,color: Colors.white,),
                                Text("Hospital",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => oxygen()));
                },
                child: Card(
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
                    width: 180,
                    child: Center(
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.flag,size: 35,color: Colors.white,),
                            Text("Oxygen",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5,2,2,2),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => medicine()));
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

                          border: Border.all(
                            color: Colors.deepPurpleAccent,
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
                              Icon(Icons.flag,size: 35,color: Colors.white,),
                              Text("Medicine",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                            ],
                          )),
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cntbnpg()));
            },
            child: Card(
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
                width: 180,
                child: Center(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag,size: 35,color: Colors.white,),
                        Text("Contribute",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                      ],
                    )),
              ),
            ),
          ),

        ],
      )
    );
  }
}
