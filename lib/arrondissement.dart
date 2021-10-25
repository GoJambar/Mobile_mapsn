import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/commun.dart';

class ArrondissmentPage extends StatefulWidget {
  dynamic arrondisment;
  ArrondissmentPage(this.arrondisment);
  @override
  _ArrondissmentPageState createState() => _ArrondissmentPageState();
}

class _ArrondissmentPageState extends State<ArrondissmentPage> {
  List<dynamic>? listeArrondissement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arrondissement de ${widget.arrondisment['name']}'),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: this.listeArrondissement == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: listeArrondissement!.length,
                itemBuilder: (context, index) {
                  //Departement departments = department![index];
                  return Card(
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                          listeArrondissement![index]["name"],
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  new CommunList(listeArrondissement![index]),
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
    var url = this.widget.arrondisment["_links"]["arron"]["href"];
    var uri = Uri.parse(url);
    http.get(uri).then((resp) {
      setState(() {
        this.listeArrondissement =
            jsonDecode(resp.body)["_embedded"]["arrondissements"];
        //  print(listeArrondissement);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
