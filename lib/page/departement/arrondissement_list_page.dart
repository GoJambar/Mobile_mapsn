import 'package:flutter/material.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/commun_list_page.dart';

class ArrondissmentPage extends StatefulWidget {
  Depart depart;
  ArrondissmentPage({required this.depart});

  // late Depart depart;
  // ArrondissmentPage(Depart depart, {required Depart depart});

  @override
  _ArrondissmentPageState createState() => _ArrondissmentPageState();
}

class _ArrondissmentPageState extends State<ArrondissmentPage> {
  List<Arron>? listeArrondissement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        title: Center(
          child: Text(
            'Departement de ${widget.depart.name}',
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
                              "Les circonscriptions administratives sont : la région, le département et l’arrondissement.La Région épartement est administré pionnaire du corps des Administrateurs civils nommé par décret et qui reçoit le titre de Sous-préfetLes chefs de circonscription sont :- Le Gouverneur pour la Région ;- Le Préfet pour le Département ;- Le Sous-préfet pour l’Arrondissement.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                      SizedBox(
                        height: 30,
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
                  'Liste des Arrondissements de ${widget.depart.name} ',
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
                  child: this.listeArrondissement == null
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: listeArrondissement!.length,
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
                                      listeArrondissement![index]
                                          .name
                                          .toString(),
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
                                        listeArrondissement![index]),
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
    listeArrondissement = widget.depart.arron;
  }
}
