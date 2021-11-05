import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/rendering.dart';
import 'package:mapsn/api/region_api.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/region/departement_list_page.dart';
import 'package:mapsn/widget/search_widget.dart';

class RegionListPage extends StatefulWidget {
  //RegionListPage(MaterialColor green);

  @override
  RegionListPageState createState() => RegionListPageState();
}

class RegionListPageState extends State<RegionListPage> {
  List<ListRegionReponse> regions = [];
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

    final reg = await RegionsApi.getRegion(query);
    if (reg.isEmpty) {
      regions.addAll(reg);
    }

    setState(() {
      this.regions = reg;
      loading = false;
      alloaded = reg.isEmpty;
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
                  child: this.regions.length == 0
                      ? CircularProgressIndicator()
                      : Stack(
                          children: [
                            GridView.builder(
                                controller: _scrollController,
                                itemCount: regions.length + (alloaded ? 1 : 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  if (index < regions.length) {
                                    int? id = regions[index].id;
                                    String? name = regions[index].name;
                                    return GestureDetector(
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Color(0xFFF5F0F0),
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Center(
                                                  child: Image.network(
                                                    'http://831a-154-125-255-70.ngrok.io/api/region/imageRegion/$id',
                                                    height: 160,
                                                    width: 160,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 5),
                                            Text(
                                              name!,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                new Departement(
                                                    region: regions[index]),
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
                                  ))
                            ]
                          ],
                        )),
              //gridRegion(regions: regions),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nom du region',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final reg = await RegionsApi.getRegion(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.regions = reg;
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
