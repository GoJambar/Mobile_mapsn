import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/arrondissement.dart';

class Departement extends StatefulWidget {
  dynamic depart;
  Departement(this.depart);
  @override
  _DepartementState createState() => _DepartementState();
}

class _DepartementState extends State<Departement> {
  List<dynamic>? listeDepartment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departement de ${widget.depart['name']}'),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: this.listeDepartment == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: listeDepartment!.length,
                itemBuilder: (context, index) {
                  //Departement departments = department![index];
                  return Card(
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                          listeDepartment![index]["name"],
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new ArrondissmentPage(
                                  listeDepartment![index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDepartement();
  }

  Future<void> loadDepartement() async {
    var url = this.widget.depart["_links"]["depart"]["href"];
    var uri = Uri.parse(url);
    http.get(uri).then((resp) {
      setState(() {
        this.listeDepartment =
            jsonDecode(resp.body)["_embedded"]["departements"];
        //print(listeDepartment);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
