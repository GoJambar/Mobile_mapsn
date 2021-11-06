import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/model/region.dart';

class ArronsApi {
  static Future<List<Arron>> getArron(String query) async {
    final url =
        Uri.parse('http://localhost:8080/api/arrondissements');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List arron = json.decode(response.body);
      //print('REGION :$region');

      return arron.map((json) => Arron.fromJson(json)).where((reg) {
        final codeRegion = reg.name!.toLowerCase();
        // final photoLower = reg.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return codeRegion.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
