import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapsn/api/commun_api.dart';
import 'package:mapsn/model/region.dart';

import 'package:mapsn/page/commun/commun_detail_page.dart';

import 'package:mapsn/widget/search_widget.dart';

class CommunListPage extends StatefulWidget {
  @override
  CommunListPageState createState() => CommunListPageState();
}

class CommunListPageState extends State<CommunListPage> {
  List<Commun> communs = [];
  String query = '';
  Timer? debouncer;
  bool loading = false;
  bool alloaded = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    init();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        print("New Data");
        init();
      }
    });
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
    _scrollController.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    if (alloaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));

    final com = await CommunsApi.getCommun(query);

    if (com.isEmpty) {
      communs.addAll(com);
    }

    setState(() {
      this.communs = com;
      loading = false;
      alloaded = com.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            header(),
            buildSearch(),
            Expanded(
              child: Center(
                child: this.communs.length == 0
                    ? CircularProgressIndicator()
                    : Stack(
                        children: [
                          GridView.builder(
                              itemCount: communs.length + (alloaded ? 1 : 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                if (index < communs.length) {
                                  int? id = communs[index].id;
                                  String? name = communs[index].name;
                                  return GestureDetector(
                                    child: Card(
                                      color: Colors.grey[500],
                                      margin: EdgeInsets.all(20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            name!,
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
                                          builder: (context) =>
                                              new CommunDetail(
                                                  commun: communs[index]),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                      height: 50,
                                      child: Center(
                                        child: Text("Nothing more to load"),
                                      ));
                                }
                              }),
                          if (loading) ...[
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                //width: constrain
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nom de la commun',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final comm = await CommunsApi.getCommun(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.communs = comm;
        });
      });

  Widget header() => Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/images/drapeau.png'),
              fit: BoxFit.cover),
        ),
      );
}
