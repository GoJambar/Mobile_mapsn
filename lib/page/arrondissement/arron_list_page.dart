import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mapsn/api/arrondissement_api.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/arrondissement/arron_detail_page.dart';
import 'package:mapsn/widget/search_widget.dart';

class ArronListPage extends StatefulWidget {
  //ArronListPage(MaterialColor blue);

  @override
  ArronListPageState createState() => ArronListPageState();
}

class ArronListPageState extends State<ArronListPage> {
  List<Arron> arrons = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
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
    final arron = await ArronsApi.getArron(query);

    //print('arrons :${reg[0].depart}');

    setState(() => this.arrons = arron);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            header(),
            buildSearch(),
            Expanded(
              child: gridDepart(arrons: arrons),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Arrondissement',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final dept = await ArronsApi.getArron(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.arrons = dept;
        });
      });

  // Widget buildBook(ListRegionResponse book) => ListTile(
  //       title: Text(book.g),
  //       subtitle: Text(book.detail),
  //     );

  Widget header() => Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/images/drapeau.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.4),
              Colors.black.withOpacity(.2),
            ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 70,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: AnimatedTextKit(totalRepeatCount: 3, animatedTexts: [
                    TypewriterAnimatedText(
                        'Eksil ak jàmm.\nLe Sénégal comprend 14 régions administratives,qui comprennent 45 départements, 133 arrondissements, 172 communes et 46 communes d’arrondissements',
                        textStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
}

class gridDepart extends StatelessWidget {
  const gridDepart({
    Key? key,
    required this.arrons,
  }) : super(key: key);

  final List<Arron> arrons;

  @override
  Widget build(BuildContext context) {
    //print('dept :${this.arrons}');

    return Center(
        child: this.arrons.length == 0
            ? CircularProgressIndicator()
            : GridView.builder(
                itemCount: arrons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  int? id = arrons[index].id;
                  String? name = arrons[index].name;
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
                              new ArronDetail(arron: arrons[index]),
                        ),
                      );
                    },
                  );
                }));
  }
}

class header extends StatelessWidget {
  const header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage('assets/images/drapeau.png'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.4),
            Colors.black.withOpacity(.2),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 70,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Center(
                child: AnimatedTextKit(totalRepeatCount: 3, animatedTexts: [
                  TypewriterAnimatedText(
                      'Eksil ak jàmm.\nLe Sénégal comprend 14 régions administratives,qui comprennent 45 départements, 133 arrondissements, 172 communes et 46 communes d’arrondissements',
                      textStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
