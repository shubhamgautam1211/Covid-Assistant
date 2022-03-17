import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
class cntbnpg extends StatefulWidget {
  @override
  _cntbnpgState createState() => _cntbnpgState();
}

class _cntbnpgState extends State<cntbnpg> {
  DatabaseReference ref;
  var _currencies = [
    "Info about Plasma avlbl",
    "Oxygen suppliers contact",
    "Hospital bed info",
    "Medicine avlbl details",
  ];
  String name,phone,alt_phone,msg,address,city;
  String _currentSelectedValue;
  bool showval=false,showval1=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.reference().child("Details");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,70,0,0),
                child: Text("Add yourself as a valuable Covid-19 info provider",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Kindly Fill Up This Form For Spreading Valuable Information",style: TextStyle(fontSize: 16,color: Colors.black),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Full Name*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value1){
                    name=value1;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Phone Number*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value2){
                    phone=value2;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Alt Phone Number*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value3){
                    alt_phone=value3;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Address*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value5){
                    address=value5;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("City*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value8){
                    city=value8;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Category*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10,10,10,0),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                height: 60,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Select Category',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue,
                          style: TextStyle(fontSize: 18,color: Colors.black),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,0,0),
                child: Text("Message*",style: TextStyle(fontSize:17,color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,10,20,10),
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey[400],// set border color
                      width: 1.0),   // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  maxLines: null,
                  maxLength: 200,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value4){
                    msg=value4;
                  },
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,10,0,0),
                    child: Checkbox(
                      value: showval,
                      onChanged: (bool value) {
                        setState(() {
                          showval = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,50,0,0),
                    child: Text("I hereby agree to the Terms and Conditions of sharing my data publicly on this app so that people can contact me for any help"
                      ,style: TextStyle(fontSize: 14,fontWeight:FontWeight.w500,color: Colors.black),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: Checkbox(
                      value: showval1,
                      onChanged: (bool value1) {
                        setState(() {
                          showval1 = value1;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,40,0,0),
                    child: Text("I agree that the information given is completely verified"
                      ,style: TextStyle(fontSize: 14,fontWeight:FontWeight.w500,color: Colors.black),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Center(
                child: SizedBox(
                  width: 100,
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(0,10,0,10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),

                    color: Colors.blueAccent,
                    onPressed: (){
                      if(showval==true && showval1==true) {
                        DateTime now = DateTime.now();
                        Map data = {
                          "NAME":name,
                          "Phone":phone,
                          "Address":address,
                          "Verified":"True",
                          "Time":now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString(),
                          "Date":now.day.toString(),
                          "Month":now.month,
                          "City":city,
                          "Alt Phone":alt_phone,
                          "Category":_currentSelectedValue,
                          "Message":msg
                        };
                        ref.child(_currentSelectedValue).push().set(data);
                      }
                      if(showval==true && showval1==false) {
                        DateTime now = DateTime.now();
                        Map data = {
                          "NAME":name,
                          "Phone":phone,
                          "Address":address,
                          "Verified":"False",
                          "Time":now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString(),
                          "Date":now.day.toString(),
                          "Month":now.month,
                          "City":city,
                          "Alt Phone":alt_phone,
                          "Category":_currentSelectedValue,
                          "Message":msg
                        };
                        ref.child(_currentSelectedValue).push().set(data);
                      }

                      else
                        print("AGREE TO THE CONDITION FIRST");
                    },
                    child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
