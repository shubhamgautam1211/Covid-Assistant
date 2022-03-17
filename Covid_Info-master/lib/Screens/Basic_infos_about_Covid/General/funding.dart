import 'package:flutter/cupertino.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class CrowdFunding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final verifiedIcon = Icon(
      CupertinoIcons.checkmark_seal_fill,
      color: Vx.white,
      size: 16.0,
    );
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,0),
          child: Text("DONATIONS",style: TextStyle(fontFamily: "Bosk",fontSize: 36,color: Colors.brown),),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://hemkuntfoundation.com/donate-now/"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                trailing: verifiedIcon,
                title: [
                  Row(
                    children: [
                      "Hemkunt Foundation".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox().red400.size(context.percentWidth * 50, 5).rounded.make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                "https://www.ketto.org/fundraiser/mission-oxygen-helping-hospitals-to-save-lives"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Mission Oxygen".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .blue400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://donate.indiacovidresources.in/"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "India Covid Resources Donate".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .orange400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                "https://fundraisers.giveindia.org/fundraisers/khaanachahiye-mumbai-is-battling-hunger-along-with-covid-19-again"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Khaana Chahiye".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .indigo400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                "https://docs.google.com/document/d/1eiobgyrl8iz-R1Dz7c4R5pzzzkuZLBj99vaC7T_UeVo/preview?pru=AAABeSyRln8*PCmPgIgWReCQfUiK7xZ3BQ"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Fundraisers".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .purple600
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://covid.giveindia.org/healthcare-heroes/"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Life Saving Equipments".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .green400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://goonj.org/donate/"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Help Migrant Workers".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),

                  10.heightBox,
                  VxBox()
                      .black
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://milaap.org/fundraisers/support-hbs-hospital"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Support the Frontline Workers".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .purple400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                "https://www.ketto.org/fundraiser/DrinkingwaterforCOVIDpatientsmumbai?utm_source=MutualAidIndia"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Water For Covid Patients".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),

                  10.heightBox,
                  VxBox()
                      .pink400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse(
                "https://www.udayfoundation.org/coronavirus-disease-covid-19/"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Uday Foundation".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),

                  10.heightBox,
                  VxBox()
                      .yellow500
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://www.akshayapatra.org/covid-relief-services"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Akshaya Patra".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .green400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
          Link(
            target: LinkTarget.blank,
            uri: Uri.parse("https://www.impactguru.com/fundraiser/oxygen"),
            builder: (context, followLink) => Card(
              child: ListTile(
                contentPadding: Vx.m16,
                title: [
                  Row(
                    children: [
                      "Oxygen Concetrators Donation".text.xl2.bold.make(),
                      SizedBox(width: 4,),
                      Icon(Icons.verified,color: Colors.blue,)
                    ],
                  ),
                  10.heightBox,
                  VxBox()
                      .orange400
                      .size(context.percentWidth * 50, 5)
                      .rounded
                      .make()
                ].vStack(crossAlignment: CrossAxisAlignment.start),
                trailing: verifiedIcon,
                onTap: followLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
