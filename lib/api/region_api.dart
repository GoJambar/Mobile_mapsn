import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapsn/model/region.dart';

class RegionsApi {
  static Future<List<ListRegionReponse>> getRegion(String query) async {
    final url = Uri.parse('http://831a-154-125-255-70.ngrok.io/api/regions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List region = json.decode(response.body);
      //print('REGION :$region');

      return region
          .map((json) => ListRegionReponse.fromJson(json))
          .where((reg) {
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
