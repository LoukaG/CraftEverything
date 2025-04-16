import 'package:craft_everything/models/craft_element.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CraftProvider {
  static Future<CraftElement?> craft(String id1, String id2) async {
    final client = http.Client();
    final response = await client.get(
      Uri.parse("http://10.0.2.2:3000/api/crafts/$id1/$id2"),
    );
    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      return CraftElement.fromJson(jsonDecode(body));
    }

    return null;
  }
}
