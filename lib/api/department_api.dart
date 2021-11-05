import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/model/region.dart';

class DepartsApi {
  static Future<List<Depart>> getDepart(String query) async {
    final url =
        Uri.parse('http://831a-154-125-255-70.ngrok.io/api/departements');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List depart = json.decode(response.body);
      //print('REGION :$region');

      return depart.map((json) => Depart.fromJson(json)).where((dept) {
        final name = dept.name!.toLowerCase();
        // final photoLower = reg.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return name.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
