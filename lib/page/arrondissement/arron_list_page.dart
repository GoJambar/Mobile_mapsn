import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapsn/api/arrondissement_api.dart';
import 'package:mapsn/model/region.dart';
import 'package:mapsn/page/arrondissement/arron_detail_page.dart';
import 'package:mapsn/widget/search_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ArronListPage extends StatefulWidget {
  //ArronListPage(MaterialColor blue);

  @override
  ArronListPageState createState() => ArronListPageState();
}

class ArronListPageState extends State<ArronListPage> {
  List<Arron> arrons = [];
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

    final arron = await ArronsApi.getArron(query);

    if (arron.isEmpty) {
      arrons.addAll(arron);
    }

    setState(() {
      this.arrons = arron;
      loading = false;
      alloaded = arron.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            logo(),
            header(),
            buildSearch(),
            Expanded(
              child: Center(
                  child: this.arrons.length == 0
                      ? CircularProgressIndicator()
                      : Stack(
                          children: [
                            GridView.builder(
                                itemCount: arrons.length + (alloaded ? 1 : 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  if (index < arrons.length) {
                                    int? id = arrons[index].id;
                                    String? name = arrons[index].name;
                                    return GestureDetector(
                                      child: Card(
                                        color: Colors.grey[500],
                                        margin: EdgeInsets.all(16),
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
                                                new ArronDetail(
                                                    arron: arrons[index]),
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

  // Widget header() => Container(
  //       width: double.infinity,
  //       height: 150,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         image: DecorationImage(
  //             image: AssetImage('assets/images/drapeau.png'),
  //             fit: BoxFit.cover),
  //       ),
  //     );
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
                    crossAxisCount: 3),
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

class logo extends StatefulWidget {
  @override
  State<logo> createState() => _logo();
}

class _logo extends State<logo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Mapsn',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
class header extends StatefulWidget {
  @override
  State<header> createState() => _header();
}

class _header extends State<header> {
  List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvHjSTSShfE4Q0bkNHTePhPkdqNTTm8x7B4w&usqp=CAU",
    //"https://flyairsenegal.com/wp-content/uploads/2021/05/CBA2D5F2-05B4-4FA6-AC88-AF90FFCDDE54.jpeg",
    "https://www.france-volontaires.org/app/uploads/2019/03/senegal-fv-banniere.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUwPe_P_XBkQyLb-yeFLGVwvdvJbs0GtcgsQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK_-0PtNj_fv0LmWyWew-4vXp-V3XFTviMpQ&usqp=CAU",
    "https://vudaf.com/wp-content/uploads/2019/07/monumentdelarenaissance.jpg",
    "https://www.onetwotrips.com/wp-content/uploads/2017/04/voyage-senegal-instagram-1.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxkXgDUhqvtEhiPlxS1uUZYZoUSE7WFn0pHw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQenEUCzYNiI0CaQnFYRlkTvjXyyGpA8k-IWg&usqp=CAU",
    //"https://senegal2019.org/wp-content/uploads/2018/12/monument-senegal.jpg",
    "https://image.shutterstock.com/image-photo/silhouette-baobab-tree-sunset-yellow-260nw-1320111641.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      CarouselSlider(
        items: imageList
            .map((e) => ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      e,
                      height: 200,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    //Text(e)
                  ],
                )))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          height: 150,
        ),
      )
    ]);
  }
}