import 'package:covid_infos/Screens/Navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    'This Channel is used for important notification',
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("A BG Message just showed up : ${message.messageId}");
}



class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  List data1=[];
  List data2=[];
  List data3=[];
  List data4=[];
  SharedPreferences prefsnewtrial;
  String str="";
  DatabaseReference ref = FirebaseDatabase().reference().child("Details");
  void initState() {
    super.initState();
    initialise();
    getdata();
    FirebaseMessaging.onMessage.listen((RemoteMessage message)
    {
      RemoteNotification notification=message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification!=null && android!=null){
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher'
                )
            )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)
    {
      print("A New onMessage opened app was published");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if(notification !=null && android!=null){
        showDialog(
            context: context,
            builder: (_){
              return AlertDialog(
                title: Text(notification.title??""),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body??"")
                    ],
                  ),
                ),
              );
            }
        );
      }
    });
  }
  initialise() async {
    prefsnewtrial=await SharedPreferences.getInstance();
  }
  getdata() async{
    _loadCSV();
  }
  void _loadCSV() async {
    var prefs,prefs1,prefs2,prefs3;
    ref.child("Hospital bed info").once().then((DataSnapshot snapshot) async {
      data1.add(snapshot.value);
      prefs=await SharedPreferences.getInstance();
      await prefs.setInt("oldLength",prefs.getInt("newLength")??0);
      await prefs.setInt("newLength",data1[0].length);
      ref.child("Info about Plasma avlbl").once().then((DataSnapshot snapshot) async {
        data2.add(snapshot.value);
        prefs1=await SharedPreferences.getInstance();
        await prefs1.setInt("oldLength1",prefs1.getInt("newLength1")??0);
        await prefs1.setInt("newLength1",data2[0].length);
        ref.child("Medicine avlbl details").once().then((DataSnapshot snapshot) async {
          data3.add(snapshot.value);
          prefs2=await SharedPreferences.getInstance();
          await prefs2.setInt("oldLength2",prefs2.getInt("newLength2")??0);
          await prefs2.setInt("newLength2",data3[0].length);
          ref.child("Oxygen suppliers contact").once().then((DataSnapshot snapshot) async {
            data4.add(snapshot.value);
            prefs3=await SharedPreferences.getInstance();
            await prefs3.setInt("oldLength3",prefs3.getInt("newLength3")??0);
            await prefs3.setInt("newLength3",data4[0].length);
            if(prefs.getInt("oldLength")!=prefs.getInt("newLength")){
              str=str+"Hospital-Bed, ";
            }
            if(prefs1.getInt("oldLength1")!=prefs1.getInt("newLength1")){
              str=str+"Plasma, ";
            }
            if(prefs2.getInt("oldLength2")!=prefs2.getInt("newLength2")){
              str=str+"Medicine avlbl, ";
            }
            if(prefs3.getInt("oldLength3")!=prefs3.getInt("newLength3")){
              str=str+"Oxygen cylinder, ";
            }
            if (str.isEmpty==false)
            {
              flutterLocalNotificationsPlugin.show(
                  0,
                  "Value changed",
                  "Someone added information about ${str}. Do check the contribution section ...",
                  NotificationDetails(
                      android: AndroidNotificationDetails(
                          channel.id,
                          channel.name,
                          channel.description,
                          importance: Importance.high,
                          color: Colors.blue,
                          playSound: true,
                          icon: '@mipmap/ic_launcher'
                      )
                  )
              );
            }
          });
        });
      });

    });

  }
  List<Map<dynamic, dynamic>> onboardingData = [
    {
      "text1": "REAL TIME UPDATE",
      "text2": "Get daily updates about the covid cases all around the world",
      "image": "Assets/Images/mask-man.svg"
    },
    {
      "text1": "NOTIFIED INSTANTLY",
      "text2": "Get instant notification about the vaccine slots available in your city",
      "image": "Assets/Images/doctors1.svg"
    },
    {
      "text1": "SHARE INFOS",
      "text2":
      "Help other patients by sharing important informations",
      "image": "Assets/Images/doctors2.svg"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Expanded(
                  flex: 2,
                  child: PageView.builder(
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(onboardingData[index]["image"]),
//                      child: Image.asset(onboardingData[index]['image'],scale: 0.6,),
                    ),
                    onPageChanged: (value) => {
                      setState(() => {
                        currentPage = value,
                      })
                    },
                  ),
                ),
                SizedBox(height: 50,),
                Expanded(
                  flex:2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                      ),
                      color: Color.fromARGB(255, 65, 186, 139),
                    ),
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      3, (index) => buildDot(index)))),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            onboardingData[currentPage]["text1"],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width-20,
                            child: Text(
                              onboardingData[currentPage]["text2"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              child: Text(
                                currentPage == (onboardingData.length - 1)
                                    ? "NEXT"
                                    : "SKIP",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.end,
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Navigation(prefsnewtrial:prefsnewtrial)));
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 30 : 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

