import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/Vaccine.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/basicinfo.dart';
import 'package:covid_infos/Screens/Basic_infos_about_Covid/General/govtinfo.dart';
import 'package:covid_infos/Screens/Contribution/contributionbody.dart';
import 'package:covid_infos/Screens/Covidcases/CountryWise.dart';
import 'package:covid_infos/Screens/Dashboard/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Navigation extends StatefulWidget {
  SharedPreferences prefsnewtrial;
  Navigation({this.prefsnewtrial});
  @override
  _NavigationState createState() => _NavigationState(prefsnewtrial:prefsnewtrial);
}

class _NavigationState extends State<Navigation> {
  SharedPreferences prefsnewtrial;
  _NavigationState({this.prefsnewtrial});
  int page=0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      homepage(prefsnewtrial:prefsnewtrial),
      country(prefsnewtrial:prefsnewtrial),
      contributionbody(),
      infos(),
    ];
    return Scaffold(
      body: tabs[page],
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home",),
            TabData(iconData: Icons.flag, title: "Countries"),
            TabData(iconData: Icons.share, title: "Contribution"),
            TabData(iconData: Icons.info, title: "Info"),
          ],
          onTabChangedListener: (position) {
            setState(() {
              page = position;
            });
          },
        )
    );
  }
}
