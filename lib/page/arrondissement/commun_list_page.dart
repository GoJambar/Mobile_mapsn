import 'package:flutter/material.dart';
import 'package:mapsn/model/region.dart';

class CommunList extends StatefulWidget {
  Commun commun;
  CommunList({required this.commun});

  @override
  _CommunListState createState() => _CommunListState();
}

class _CommunListState extends State<CommunList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        title: Center(
          child: Text(
            'Commune de ${widget.commun.name}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                      Colors.white.withOpacity(.4),
                      Colors.black.withOpacity(.2),
                    ]),
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            //padding: EdgeInsets.all(10),
                            child: Text(
                              "la commune de ${widget.commun.name} est caractérisé par une superficie de ${widget.commun.superficie} Km2, une population de ${widget.commun.population} habitants, avec ${widget.commun.latitude} de latitude et ${widget.commun.longitute} de longitude",
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // listCommun = widget.commun;
  }
}
