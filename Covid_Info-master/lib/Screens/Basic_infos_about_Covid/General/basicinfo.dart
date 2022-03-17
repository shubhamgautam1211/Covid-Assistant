import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/Contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
class infos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(90,40,0,20),
                  child: Image.asset("Assets/Images/CROPPED.jpeg",scale: 4,),
                )
              ],),
          Text("Most people who become sick with COVID-19 will only experience mild illness and can recover at home. Symptoms might last a few days, and people who have the virus might feel better in about a week. Treatment is aimed at relieving symptoms and includes rest, fluid intake and pain relievers."
            ,style: TextStyle(fontSize: 18)),

          20.heightBox,

          Text("Protecting yourself while caring for someone with COVID-19",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          SizedBox(height: 30,),

          [
            // if (!Vx.isWeb)
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: SvgPicture.asset("Assets/Images/Infos1.svg",
                height: 300.0,
              ).w32(context).centered(),
            ),
            Expanded(
              flex: 3,
              child: Wrap(
                children: <Widget>[
                  Text('1. Keep your hands clean and away from your face',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('2. Wear a face mask',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('3. Clean your home frequently',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('4. Be careful with laundry',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('5. Be careful with dishes',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text("6. Avoid direct contact with the sick person's bodily fluids",style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('7. Avoid having unnecessary visitors in your home',style: TextStyle(fontSize: 17),),

                ],
              ),
            ),
          ].hStack(crossAlignment: CrossAxisAlignment.start),

          30.heightBox,

          "Emergency warning signs".text.xl2.bold.make(),

          SizedBox(height: 15,),

          [
            Expanded(
              flex: 3,
              child: Wrap(
                children: <Widget>[
                  Text('* Trouble breathing',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('* Persistent chest pain or pressure',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('* New confusion',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('* Inability to stay awake',style: TextStyle(fontSize: 17),),
                  Text("                                                  ",style: TextStyle(fontSize: 10),),
                  Text('* Pale, gray or blue-colored skin, lips or nail beds — depending on skin tone',style: TextStyle(fontSize: 17),),

                ],
              ),
            ),
            // if (!Vx.isWeb)
            SvgPicture.asset("Assets/Images/Infos2.svg",
              height: 200.0,
            ).w32(context).centered(),
          ].hStack(crossAlignment: CrossAxisAlignment.start),

          20.heightBox,

          "At-Home Coronavirus Treatment".text.xl2.bold.make(),

          VxDiscList(
            [
              "Rest. It can make you feel better and may speed your recovery.",
              "Sleep in the Prone Position",
              "Stay home. Don't go to work, school, or public places.",
              "Drink fluids. You lose more water when you're sick. Dehydration can make symptoms worse and cause other health problems",
              "Monitor. If your symptoms get worse, call your doctor right away. Don't go to their office without calling first. They might tell you to stay home, or they may need to take extra steps to protect staff and other patients.",
              "Ask your doctor about over-the-counter medicines that may help, like acetaminophen to lower your fever.",
            ],
            fontSize: 17,
            color: context.textTheme.bodyText1.color,
          ),

          20.heightBox,

          "Monitoring Tips".text.xl2.bold.make(),

          VxDiscList(
            [
              "Keep the fans on and windows open",
              "Have a thermometer and pulse oximeter to monitor regularly",
              "Remember to wipe them between use",
              "Measure Pulse, O2 Saturation and Temperature every 6 hours",
              "Immediately consult your doctor if saturation goes below 90-92",
            ],
            fontSize: 17,
            color: context.textTheme.bodyText1.color,
          ),

          20.heightBox,

          "Some simple useful medicines for everyone (Consult doctor if required or in emergency)"
              .text
              .xl2
              .bold
              .make(),
          [
            VxDiscList(
              [
                "Paracetamol for fever",
                "Budesonide for Inhalation",
                "Karvol Plus for steam",
                "Azithromycin",
                "Doxycycline",
                "Vitamin C & Zinc"
              ],
              fontSize: 17,
              color: context.textTheme.bodyText1.color,
            ).w56(context),
            // if (!Vx.isWeb)
            SvgPicture.asset("Assets/Images/Infos3.svg",
              height: 200.0,
            ).w32(context).centered(),
          ].hStack(),
        ],
      ).p16().scrollVertical(),
    );
  }
}