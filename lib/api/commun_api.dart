import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/model/region.dart';

class CommunsApi {
  static Future<List<Commun>> getCommun(String query) async {
    final url =
        Uri.parse('http://831a-154-125-255-70.ngrok.io/api/arrondissements');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List arron = json.decode(response.body);
      //print('REGION :$region');

      return arron.map((json) => Commun.fromJson(json)).where((reg) {
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
