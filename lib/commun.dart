import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunList extends StatefulWidget {
  dynamic commun;
  CommunList(this.commun);
  @override
  _CommunListState createState() => _CommunListState();
}

class _CommunListState extends State<CommunList> {
  List<dynamic>? listCommun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commun de ${widget.commun['name']}'),
      ),
      body: Center(
        child: this.listCommun == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: listCommun!.length,
                itemBuilder: (context, index) {
                  //Departement departments = department![index];
                  return Card(
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                          listCommun![index]["name"],
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: null,
                        //() {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => new CommunList(
                        //           listCommun[index]),
                        //     ),
                        //   );
                        // },
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
    loadCommun();
  }

  void loadCommun() {
    var url = this.widget.commun["_links"]["commun"]["href"];
    var uri = Uri.parse(url);
    http.get(uri).then((resp) {
      setState(() {
        this.listCommun = jsonDecode(resp.body)["_embedded"]["communs"];
        //print(listCommun);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
