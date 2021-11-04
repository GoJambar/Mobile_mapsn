import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mapsn/api/department_api.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/departement/departement_detail_page.dart';
import 'package:mapsn/widget/search_widget.dart';

class DepartListPage extends StatefulWidget {
  @override
  DepartListPageState createState() => DepartListPageState();
}

class DepartListPageState extends State<DepartListPage> {
  List<Depart> departs = [];
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
    final reg = await DepartsApi.getDepart(query);

    setState(() => this.departs = reg);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            header(),
            buildSearch(),
            Expanded(
              child: gridDepart(departs: departs),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nom du departement',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final dept = await DepartsApi.getDepart(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.departs = dept;
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
    required this.departs,
  }) : super(key: key);

  final List<Depart> departs;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: this.departs.length == 0
            ? CircularProgressIndicator()
            : GridView.builder(
                itemCount: departs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  int? id = departs[index].id;
                  String? name = departs[index].name;
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
                          builder: (context) => new DepartementDetail(
                            dept: departs[index],
                          ),
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