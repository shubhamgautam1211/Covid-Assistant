import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_infos/DataFetching/countrywise.dart';
import 'package:covid_infos/Provider/Onsearch.dart';
import 'package:covid_infos/Screens/Covidcases/Indivisual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class country extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  country({this.prefsnewtrial});
  @override
  _countryState createState() => _countryState();
}

class _countryState extends State<country> {
  final fieldText = TextEditingController();
  final imageList = [
    "Assets/Images/Carousel1.jpg",
    "Assets/Images/Carousel2.jpg",
    "Assets/Images/Carousel3.jpg",
    "Assets/Images/Carousel4.jpg",
    "Assets/Images/Carousel5.jpg",
    "Assets/Images/Carousel6.jpg",
    "Assets/Images/Carousel7.jpg",
    "Assets/Images/Carousel8.jpg",
    "Assets/Images/Carousel9.jpeg",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<onsearch>(
      create: (context) => onsearch(),
      child: Builder(
        builder: (context){
          return FutureBuilder(
            future: countrywise().countries(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var value = snapshot.data;
                List decodedJson = json.decode(value.body);
                String countriesdatastring=json.encode(decodedJson);
                widget.prefsnewtrial.setString("Countydata",countriesdatastring);
                return Consumer<onsearch>(
                  builder: (context,data,child){
                    return Scaffold(
                      appBar: data.updatesearch()?AppBar(
                        actions: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,5,0,0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.black,)),
                              ),
                              width: 230,
                              child: TextField(
                                cursorColor: Colors.black,
                                controller: fieldText,
                                style: TextStyle(color: Colors.white,fontSize: 20),
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              data.searchclear();
                              fieldText.clear();
                              data.offpresssearch();
                            },
                            icon: Icon(Icons.cancel,color: Colors.white,),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){
                              for (int i=0;i<decodedJson.length;i++){
                                if (fieldText.text==decodedJson[i]["country"]){
                                  data.countryfound(i);
                                }
                              };
                              if (fieldText.text.isEmpty && data.countryfound1()==-1){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a Country")));
                              }
                              if(fieldText.text.isNotEmpty && data.countryfound1()==-1){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Such Country Found . Check Spelling !!!")));
                              }
                            },
                          )
                        ],
                        bottom: PreferredSize(
                          preferredSize: Size(0.0, MediaQuery.of(context).size.height/4.5),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,14),
                            child: Container(
                              height: 170,
                              child: Swiper(
                                autoplay: true,
                                duration: 200,
                                itemCount: imageList.length,
                                layout: SwiperLayout.STACK,
                                itemWidth: MediaQuery.of(context).size.width-50,
                                itemHeight: 300.0,
                                itemBuilder: (context,index){
                                  return Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width-50,
                                    child: Image(
                                      image: AssetImage(imageList[index]),
                                      alignment: Alignment.center,
                                      height: 170,
                                      width: MediaQuery.of(context).size.width - 10,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ) : AppBar(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        title: Center(child: Text("Countries Cases")),
                        actions: [
                          IconButton(
                              icon:Icon(Icons.search),
                              onPressed: (){
                                data.onpresssearch();
                              })
                        ],
                        bottom: PreferredSize(
                          preferredSize: Size(0.0, MediaQuery.of(context).size.height/4.5),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,14),
                            child: Container(
                              height: 170,
                              child: Swiper(
                                autoplay: true,
                                duration: 200,
                                itemCount: imageList.length,
                                layout: SwiperLayout.STACK,
                                itemWidth: MediaQuery.of(context).size.width-50,
                                itemHeight: 300.0,
                                itemBuilder: (context,index){
                                  return Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width-50,
                                    child: Image(
                                      image: AssetImage(imageList[index]),
                                      alignment: Alignment.center,
                                      height: 170,
                                      width: MediaQuery.of(context).size.width - 10,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      body: data.countryfound1()==-1?
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: decodedJson.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => indivisual(decodedjson:decodedJson,index:index)));
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(4,12,12,8),
                                    child: ListTile(
                                      leading: Hero(
                                        tag: decodedJson[index]["country"],
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            imageUrl: decodedJson[index]["countryInfo"]["flag"],
                                          ),
                                        ),
                                      ),
                                      title: Text(decodedJson[index]["country"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                      subtitle: Row(
                                        children: [
                                          Text("Total Cases:"),
                                          Text(decodedJson[index]["cases"].toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                          :ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => indivisual(decodedjson:decodedJson,index:data.countryfound1())));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4,12,12,8),
                                  child: ListTile(
                                    leading: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageUrl: decodedJson[data.countryfound1()]["countryInfo"]["flag"],
                                      )
                                    ),
                                    title: Text(decodedJson[data.countryfound1()]["country"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    subtitle: Row(
                                      children: [
                                        Text("Total Cases:"),
                                        Text(decodedJson[data.countryfound1()]["cases"].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),

                    );
                  },
                );
              }
              else{
                if(widget.prefsnewtrial.containsKey("Countydata")){
                  final yourStr = widget.prefsnewtrial.getString("Countydata");
                  List Countrydataconverted = json.decode(yourStr);
                  print(widget.prefsnewtrial);
                  return Consumer<onsearch>(
                    builder: (context,data,child){
                      return Scaffold(
                        appBar: data.updatesearch()?AppBar(
                          actions: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,5,0,0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.black,)),
                                ),
                                width: 230,
                                child: TextField(
                                  cursorColor: Colors.black,
                                  controller: fieldText,
                                  style: TextStyle(color: Colors.white,fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                data.searchclear();
                                fieldText.clear();
                                data.offpresssearch();
                              },
                              icon: Icon(Icons.cancel,color: Colors.white,),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: (){
                                for (int i=0;i<Countrydataconverted.length;i++){
                                  if (fieldText.text==Countrydataconverted[i]["country"]){
                                    data.countryfound(i);
                                  }
                                };
                                if (fieldText.text.isEmpty && data.countryfound1()==-1){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a Country")));
                                }
                                if(fieldText.text.isNotEmpty && data.countryfound1()==-1){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Such Country Found . Check Spelling !!!")));
                                }
                              },
                            )
                          ],
                          bottom: PreferredSize(
                            preferredSize: Size(0.0, MediaQuery.of(context).size.height/4.5),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,14),
                              child: Container(
                                height: 170,
                                child: Swiper(
                                  autoplay: true,
                                  duration: 200,
                                  itemCount: imageList.length,
                                  layout: SwiperLayout.STACK,
                                  itemWidth: MediaQuery.of(context).size.width-50,
                                  itemHeight: 300.0,
                                  itemBuilder: (context,index){
                                    return Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width-50,
                                      child: Image(
                                        image: AssetImage(imageList[index]),
                                        alignment: Alignment.center,
                                        height: 170,
                                        width: MediaQuery.of(context).size.width - 10,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ) : AppBar(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          title: Center(child: Text("Countries Cases")),
                          actions: [
                            IconButton(
                                icon:Icon(Icons.search),
                                onPressed: (){
                                  data.onpresssearch();
                                })
                          ],
                          bottom: PreferredSize(
                            preferredSize: Size(0.0, MediaQuery.of(context).size.height/4.5),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,14),
                              child: Container(
                                height: 170,
                                child: Swiper(
                                  autoplay: true,
                                  duration: 200,
                                  itemCount: imageList.length,
                                  layout: SwiperLayout.STACK,
                                  itemWidth: MediaQuery.of(context).size.width-50,
                                  itemHeight: 300.0,
                                  itemBuilder: (context,index){
                                    return Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width-50,
                                      child: Image(
                                        image: AssetImage(imageList[index]),
                                        alignment: Alignment.center,
                                        height: 170,
                                        width: MediaQuery.of(context).size.width - 10,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        body: data.countryfound1()==-1?
                        Container(
                          height: 500,
                          child: ListView.builder(
                              itemCount: Countrydataconverted.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => indivisual(decodedjson:Countrydataconverted,index:index)));
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(4,12,12,8),
                                      child: ListTile(
                                        leading: Hero(
                                          tag: Countrydataconverted[index]["country"],
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              imageUrl: Countrydataconverted[index]["countryInfo"]["flag"],
                                            ),
                                          ),
                                        ),
                                        title: Text(Countrydataconverted[index]["country"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                        subtitle: Row(
                                          children: [
                                            Text("Total Cases:"),
                                            Text(Countrydataconverted[index]["cases"].toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                            :ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => indivisual(decodedjson:Countrydataconverted,index:data.countryfound1())));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(4,12,12,8),
                                    child: ListTile(
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          imageUrl: Countrydataconverted[data.countryfound1()]["countryInfo"]["flag"],
                                        ),                                    ),
                                      title: Text(Countrydataconverted[data.countryfound1()]["country"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                      subtitle: Row(
                                        children: [
                                          Text("Total Cases:"),
                                          Text(Countrydataconverted[data.countryfound1()]["cases"].toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),

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
          );
        },
      ),
    );
  }
}