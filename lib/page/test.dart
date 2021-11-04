// import 'dart:async';
// import 'package:filter_listview_example/api/books_api.dart';
// import 'package:filter_listview_example/model/region.dart';
// import 'package:filter_listview_example/page/depatement.dart';
// import 'package:filter_listview_example/widget/search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

// class FilterNetworkListPage extends StatefulWidget {
//   @override
//   FilterNetworkListPageState createState() => FilterNetworkListPageState();
// }

// class FilterNetworkListPageState extends State<FilterNetworkListPage> {
//   List<Region> regions = [];
//   String query = '';
//   Timer? debouncer;

//   @override
//   void initState() {
//     super.initState();

//     init();
//   }

//   @override
//   void dispose() {
//     debouncer?.cancel();
//     super.dispose();
//   }

//   void debounce(
//     VoidCallback callback, {
//     Duration duration = const Duration(milliseconds: 1000),
//   }) {
//     if (debouncer != null) {
//       debouncer!.cancel();
//     }

//     debouncer = Timer(duration, callback);
//   }

//   Future init() async {
//     final reg = await RegionsApi.getRegion(query);

//     setState(() => this.regions = reg);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Column(
//           children: <Widget>[
//             header(),
//             buildSearch(),
//             Expanded(
//               child: gridRegion(regions: regions),
//             ),
//           ],
//         ),
//       );

//   Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Title or Author Name',
//         onChanged: searchBook,
//       );

//   Future searchBook(String query) async => debounce(() async {
//         final books = await RegionsApi.getRegion(query);

//         if (!mounted) return;

//         setState(() {
//           this.query = query;
//           this.regions = books;
//         });
//       });

//   Widget buildBook(Region book) => ListTile(
//         title: Text(book.name),
//         subtitle: Text(book.detail),
//       );

//   Widget header() => Container(
//         width: double.infinity,
//         height: 150,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           image: DecorationImage(
//               image: AssetImage('assets/images/drapeau.png'),
//               fit: BoxFit.cover),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
//               Colors.black.withOpacity(.4),
//               Colors.black.withOpacity(.2),
//             ]),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Container(
//                 height: 70,
//                 padding: EdgeInsets.all(10),
//                 margin: EdgeInsets.symmetric(horizontal: 40),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white),
//                 child: Center(
//                   child: AnimatedTextKit(totalRepeatCount: 3, animatedTexts: [
//                     TypewriterAnimatedText(
//                         'Eksil ak jàmm.\nLe Sénégal comprend 14 régions administratives,qui comprennent 45 départements, 133 arrondissements, 172 communes et 46 communes d’arrondissements',
//                         textStyle: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold)),
//                   ]),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       );
// }

// class gridRegion extends StatelessWidget {
//   const gridRegion({
//     Key? key,
//     required this.regions,
//   }) : super(key: key);

//   final List<Region> regions;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: this.regions == null
//             ? CircularProgressIndicator()
//             : GridView.builder(
//                 itemCount: regions.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//                 itemBuilder: (context, index) {
//                   int? id = regions[index].id;
//                   return GestureDetector(
//                     child: Card(
//                       elevation: 10,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       color: Color(0xFFF5F0F0),
//                       margin: EdgeInsets.all(10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               child: Center(
//                                 child: Image.network(
//                                   'http://localhost:8080/api/region/imageRegion/$id',
//                                   height: 160,
//                                   width: 160,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // SizedBox(height: 5),
//                           Text(
//                             regions[index].name,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           )
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               new Departement(region: regions[index]),
//                         ),
//                       );
//                     },
//                   );
//                 }));
//   }
// }

// class header extends StatelessWidget {
//   const header({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 150,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(
//             image: AssetImage('assets/images/drapeau.png'), fit: BoxFit.cover),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
//             Colors.black.withOpacity(.4),
//             Colors.black.withOpacity(.2),
//           ]),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Container(
//               height: 70,
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(horizontal: 40),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10), color: Colors.white),
//               child: Center(
//                 child: AnimatedTextKit(totalRepeatCount: 3, animatedTexts: [
//                   TypewriterAnimatedText(
//                       'Eksil ak jàmm.\nLe Sénégal comprend 14 régions administratives,qui comprennent 45 départements, 133 arrondissements, 172 communes et 46 communes d’arrondissements',
//                       textStyle: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold)),
//                 ]),
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
