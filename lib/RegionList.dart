import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapsn/Departement.dart';

class RegionList extends StatefulWidget {
  @override
  _RegionListState createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  List<dynamic>? region;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les Regions du senegal'),
      ),
      body: Center(
        child: this.region == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: region!.length,
                itemBuilder: (context, index) {
                  int id = region![index]["id"];
                  return Card(
                    color: Colors.black38,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              child: Image.network(
                                'http://e215-154-124-66-161.ngrok.io/api/region/imageRegion/$id',
                                width: 400,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: Text(
                                    region![index]["name"],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            new Departement(region![index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //if (this.region![index] != null)
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Image.network(
                            //         'http://58ec-154-124-236-171.ngrok.io/api/region/imageRegion/$id')

                            //   ],
                            // )
                          ],
                        )),
                  );
                }),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() {
    var url = Uri.parse('http://e215-154-124-66-161.ngrok.io/regions');
    http.get(url).then((resp) {
      setState(() {
        region = jsonDecode(resp.body)["_embedded"]["regions"];
        //print(department);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
