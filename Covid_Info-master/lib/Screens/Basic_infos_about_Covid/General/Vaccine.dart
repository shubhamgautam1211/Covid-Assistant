import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/Dateslot.dart';
import 'package:covid_infos/ConvertDate/Conversion.dart';
import 'package:covid_infos/Provider/Onsearch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class vaccine extends StatefulWidget {
  @override
  _vaccineState createState() => _vaccineState();
}

class _vaccineState extends State<vaccine> {
  DateTime _selectedDate;
  String date1,city;
  int difference,statesid,districtid;
  bool pressed;
  var infos,infos1,infos2;

  Future getData(String finaldate, String city) async{
    String myUrl="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=${city}&date=${finaldate}";
    var req = await http.get(myUrl);
    setState(() {
      infos = json.decode(req.body);
    });
  }

  Future getStateData() async{
    String myUrl="https://cdn-api.co-vin.in/api/v2/admin/location/states";
    var req1 = await http.get(myUrl);
    setState(() {
      infos1 = json.decode(req1.body);
    });
  }

  Future getdistrictdata(int statesid, String converteddate) async{
    String myUrl="https://cdn-api.co-vin.in/api/v2/admin/location/districts/${statesid}";
    var req1 = await http.get(myUrl);
    setState(() {
      infos2 = json.decode(req1.body);
    });
    for (int i=0;i<infos2["districts"].length;i++){
      if (_textEditingController3.text==infos2["districts"][i]["district_name"]){
        districtid=infos2["districts"][i]["district_id"];
      }
    }
    getvaccinedetails(districtid,converteddate);
  }

  Future getvaccinedetails(int districtid, String converteddate) async{
    String myUrl="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=${districtid}&date=${converteddate}";
    var req1 = await http.get(myUrl);
    setState(() {
      infos = json.decode(req1.body);
    });

  }

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pressed=false;
    getStateData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Icon(Icons.arrow_back,size: 30,color: Colors.black,),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0,5,20,0),
          child: Text("Search For Vaccine",style: TextStyle(fontFamily: "Bosk",fontSize: 30,color: Colors.brown),),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50,15,50,0),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today,size: 25,),
                    onPressed: (){
                      _selectDate(context);
                    },
                  ),
                  labelText: ("Enter Date"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person,size: 30,color: Colors.blueAccent,),
                  filled: true,
                ),
                controller: _textEditingController,style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50,10,50,5),
              child: TextField(
                decoration: InputDecoration(
                  labelText: ("Enter Pincode"),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city,size: 30,color: Colors.blueAccent,),
                  filled: true,
                ),
                onChanged: (text){
                  setState(() {
                    city=text;
                  });
                },
                controller: _textEditingController1,style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10,),
            Text("OR",style: TextStyle(fontSize: 25),),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: ("State"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city,size: 30,color: Colors.blueAccent,),
                      filled: true,
                    ),
                    controller: _textEditingController2,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: ("District"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city,size: 30,color: Colors.blueAccent,),
                      filled: true,
                    ),
                    controller: _textEditingController3,style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,10,0,0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  elevation: 5,
                  onPressed: (){
                    String date=_textEditingController.text.replaceAll(" ","");
                    String date1 = date.replaceAll(",","");
                    String converteddate = Converteddata1(date1);
                    if(_textEditingController1.text.isEmpty==true){
                      for (int i=0;i<infos1["states"].length;i++){
                        if(_textEditingController2.text==infos1["states"][i]["state_name"]){
                          setState(() {
                            statesid=infos1["states"][i]["state_id"];
                          });
                          getdistrictdata(statesid,converteddate);
                        }
                      }
                    }
                    if(_textEditingController1.text.isEmpty==false){
                      getData(converteddate,city);
                    }
                    setState(() {
                      pressed=true;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Text("CLICK",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            pressed?Container(
              height: 280,
              child: ListView.builder(
                  itemCount: infos==null?0:infos["centers"].length,
                  itemBuilder: (context,index){
                    return Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Map slot = infos["centers"][index] as Map;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => dateslot(slot:slot)));
                              },
                              child: Container(
                                height: 60,
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                    child: CachedNetworkImage(
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      imageUrl: "https://media.istockphoto.com/photos/long-and-dark-hospital-hallway-picture-id108162808?k=6&m=108162808&s=170667a&w=0&h=Fp2DJR6bG6-6oz4LHi09VQaL77_Ys0syNv2fD-Tcixs=",
                                    ),
                                  ),
                                  title: Text(infos["centers"][index]["name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30,left: 70),
                              child: Divider(
                                thickness: 1,
                              ),
                            )
                          ],
                        ),
                    );
                  }),
                )
                :Text(""),
            SizedBox(height: 10,),
            Text("Get Vaccinated",
              style: GoogleFonts.lobster(
                  textStyle: TextStyle(color: Colors.purple,fontSize: 50,shadows:[
                    Shadow(
                    blurRadius: 2.0,
                    color: Colors.pink,
                    offset: Offset(1.0, 1.0),
                  ),
                ],)),
            )],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}