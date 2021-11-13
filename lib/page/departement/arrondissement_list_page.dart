import 'package:flutter/material.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/departement/commun_list_page.dart';

class ArrondissmentPage extends StatefulWidget {
  Arron arron;
  ArrondissmentPage({required this.arron});

  @override
  _ArrondissmentPageState createState() => _ArrondissmentPageState();
}

class _ArrondissmentPageState extends State<ArrondissmentPage> {
  List<Commun>? listeCommun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        title: Center(
          child: Text(
            'Arrondissment de ${widget.arron.name}',
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
                              "l'arrondissement de ${widget.arron.name} est caractérisé par une superficie de ${widget.arron.superficie} Km2, une population de ${widget.arron.population} habitants, avec ${widget.arron.latitude} de latitude et ${widget.arron.longitute} de longitude",
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
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2))),
                child: Text(
                  'Liste des Communs de ${widget.arron.name} ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  // ignore: unnecessary_null_comparison
                  child: this.listeCommun == null
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: listeCommun!.length,
                          itemBuilder: (context, index) {
                            //Departement departments = department![index];
                            return GestureDetector(
                              child: Card(
                                color: Colors.grey[500],
                                margin: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      listeCommun![index].name.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => new CommunList(
                                      commun: listeCommun![index],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                ),
              )
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
    listeCommun = widget.arron.commun;
  }
}
