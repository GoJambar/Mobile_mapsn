import 'package:flutter/material.dart';
import 'package:mapsn/page/arrondissement/arron_list_page.dart';
import 'package:mapsn/page/commun/commun_list_page.dart';
import 'package:mapsn/page/departement/departement_list_page.dart';
import 'package:mapsn/page/region/region_list_page.dart';

import '../icons.dart';

class BootomBarScreen extends StatefulWidget {
  BootomBarScreen() : super();

  //final String title = "Flutter Bottom Tab demo";

  @override
  _BootomBarScreenState createState() => _BootomBarScreenState();
}

class _BootomBarScreenState extends State<BootomBarScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    RegionListPage(),
    DepartListPage(),
    ArronListPage(),
    CommunListPage(),
  ];
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.blueGrey,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.table),
            label: "Regions",
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.list_alt),
            label: "Departement",
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.th_large),
            label: "Arrondissement",
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.menu),
            label: "Commun",
          ),
        ],
      ),
    );
  }
}
