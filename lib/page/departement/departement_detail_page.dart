import 'package:flutter/material.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/departement/arrondissement_list_page.dart';

// ignore: must_be_immutable
class DepartementDetail extends StatefulWidget {
  Depart dept;
  DepartementDetail({required this.dept});
  @override
  _DepartementDetailState createState() => _DepartementDetailState();
}

class _DepartementDetailState extends State<DepartementDetail> {
  List<Arron>? listArron;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        title: Center(
          child: Text(
            'Departement de ${widget.dept.name}',
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
                              'le département de ${widget.dept.name} est caractérisé par une superficie de ${widget.dept.superficie} Km2, une population de ${widget.dept.population} habitants, avec ${widget.dept.latitude} de latitude et ${widget.dept.longitute} de longitude',
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
                  'Liste des Arondissements de ${widget.dept.name} ',
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
                  child: this.listArron == null
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: listArron!.length,
                          itemBuilder: (context, index) {
                            //DepartementDetail departments = department![index];
                            return GestureDetector(
                              child: Card(
                                color: Colors.grey[500],
                                margin: EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      listArron![index].name.toString(),
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
                                    builder: (context) => new ArrondissmentPage(
                                      arron: listArron![index],
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
    listArron = widget.dept.arron;
    // loadDepartementDetail();
  }
}
