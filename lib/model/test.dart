// import 'dart:async';
// import 'dart:convert';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mapsn/screens/Departement.dart';

// class RegionList extends StatefulWidget {
//   @override
//   _RegionListState createState() => _RegionListState();
// }

// class _RegionListState extends State<RegionList> {
//   List<dynamic>? region;
//   List<dynamic> books = [];
//   String query = '';
//   Timer? debouncer;
//   TextEditingController queryText = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white10,
//         body: SafeArea(
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   width: double.infinity,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/drapeau.png'),
//                         fit: BoxFit.cover),
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient:
//                           LinearGradient(begin: Alignment.bottomRight, colors: [
//                         Colors.black.withOpacity(.4),
//                         Colors.black.withOpacity(.2),
//                       ]),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         Container(
//                           height: 70,
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.symmetric(horizontal: 40),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white),
//                           child: Center(
//                             child: AnimatedTextKit(
//                                 totalRepeatCount: 3,
//                                 animatedTexts: [
//                                   TypewriterAnimatedText(
//                                       'Eksil ak jàmm.\nLe Sénégal comprend 14 régions administratives,qui comprennent 45 départements, 133 arrondissements, 172 communes et 46 communes d’arrondissements',
//                                       textStyle: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold)),
//                                 ]),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 search(),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: Center(
//                       child: this.region == null
//                           ? CircularProgressIndicator()
//                           : GridView.builder(
//                               itemCount: region!.length,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2),
//                               itemBuilder: (context, index) {
//                                 int id = region![index]["id"];
//                                 return GestureDetector(
//                                   child: Card(
//                                     elevation: 10,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     color: Color(0xFFF5F0F0),
//                                     margin: EdgeInsets.all(10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                           child: Container(
//                                             child: Center(
//                                               child: Image.network(
//                                                 'http://5abb-154-125-106-67.ngrok.io/api/region/imageRegion/$id',
//                                                 height: 160,
//                                                 width: 160,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         // SizedBox(height: 5),
//                                         Text(
//                                           region![index]["name"],
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             new Departement(region![index]),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               })),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetch();
//     search();
//   }

//   void fetch() {
//     var url = Uri.parse('http://5abb-154-125-106-67.ngrok.io/regions');
//     http.get(url).then((resp) {
//       setState(() {
//         region = jsonDecode(resp.body)["_embedded"]["regions"];
//         //print(department);
//       });
//     }).catchError((onError) {
//       print(onError);
//     });
//   }

//   void seacrh(String query) {
//     var url = Uri.parse('http://localhost:8080/api/region/${query}');
//     http.get(url).then((resp) {
//       setState(() {
//         region = jsonDecode(resp.body);
//         //print(department);
//       });
//     }).catchError((onError) {
//       print(onError);
//     });
//   }

//   Widget search() {
//     return Container(
//       height: 50,
//       margin: EdgeInsets.symmetric(vertical: 20),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.grey[500],
//         borderRadius: BorderRadius.circular(29.5),
//       ),
//       child: TextField(
//         controller: queryText,
//         decoration: InputDecoration(
//           hintText: "Search",
//           hintStyle: TextStyle(
//             fontSize: 15.0,
//             color: Colors.white,
//           ),
//           icon: Icon(
//             Icons.search,
//             color: Colors.white,
//             size: 20,
//           ),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
