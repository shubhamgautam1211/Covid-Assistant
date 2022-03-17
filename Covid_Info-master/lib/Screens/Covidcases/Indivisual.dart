import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/basicinfo.dart';
import 'package:covid_infos/Screens/Covidcases/statewise.dart';
import 'package:covid_infos/Services/totalsample.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
class indivisual extends StatefulWidget {
  List decodedjson;
  int index;
  indivisual({this.decodedjson,this.index});
  @override
  _indivisualState createState() => _indivisualState(decodedjson:decodedjson,index:index);
}

class _indivisualState extends State<indivisual> {
  List decodedjson;
  int index;
  _indivisualState({this.decodedjson,this.index});
  @override
  Widget build(BuildContext context) {
    double percentage = (decodedjson[index]["cases"])/(decodedjson[index]["population"])*10;
    int a = (percentage*100).toInt();
    double b = a/100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: decodedjson[index]["country"],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,70,0,0),
                  child: Container(
                    child: CachedNetworkImage(
                      height: 90,
                      fit: BoxFit.cover,
                      imageUrl: decodedjson[index]["countryInfo"]["flag"]),
                    ),
                  ),
                ),
              SizedBox(height: 20,),
              decodedjson[index]["country"].length>16?SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Text(decodedjson[index]["country"],
                    style: TextStyle(fontFamily: "SurfingCapital",fontWeight: FontWeight.w600,fontSize:30,color: Colors.black,letterSpacing: 3),),
                ),
              )
              :SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Text(decodedjson[index]["country"],
                    style: TextStyle(fontFamily: "SurfingCapital",fontSize:60,color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 3),),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,10,0,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
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
                                Text("Total Cases",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Helvetica",),),
                                Text(decodedjson[index]["cases"].toString(),style: TextStyle(color: Colors.white,fontSize: 23),),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,2,2,2),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(10,190,60,1),
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
                                  Text("Recovered",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Helvetica",),),
                                  Text(decodedjson[index]["recovered"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: b>1.0?b/10:b,
                center: b>1.0?Text(
                  (((b*100/10).toInt())).toString()+"%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ):Text(
                  (b*100).toString()+"%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                footer: Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: new Text(
                    "Approx Affection With Covid",
                    style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.orange,
                progressColor: Colors.red[700],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(220,28,49,1),
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
                              Text("Total Death",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                              Text(decodedjson[index]["deaths"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,2,2,2),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
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
                                Text("Active Cases",style: TextStyle(fontFamily: "Helvetica",color: Colors.white,fontSize: 25),),
                                Text(decodedjson[index]["active"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                              ],
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              decodedjson[index]["country"]=="India"?AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,15,35),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff2c274c),
                          Color(0xff46426c),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 27,
                            ),
                            const Text(
                              'Total Cases',
                              style: TextStyle(
                                color: Color(0xff827daa),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Covid Count in India',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 37,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                                child: LineChart(
                                  sampleData1(),
                                  swapAnimationDuration: const Duration(milliseconds: 250),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ):
              Text("")
            ],
          ),
        ),
      ),
    );
  }
  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Apr';
              case 3:
                return 'July';
              case 5:
                return 'Oct';
              case 7:
                return 'Jan';
              case 9:
                return 'Mar';
              case 11:
                return 'May';
              case 13:
                return 'Jun';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '50000';
              case 2:
                return '125000';
              case 3:
                return '250000';
              case 4:
                return '325000';
              case 5:
                return '400000';
              case 6:
                return '500000';
            }
            return '';
          },
          margin: 0,
          reservedSize: 60,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 0.01),
        FlSpot(3, 0.5),
        FlSpot(5, 1.6),
        FlSpot(7, 0.3),
        FlSpot(9, 0.6),
        FlSpot(11, 5.3),
        FlSpot(13,2.2),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1,
    ];
  }
}
