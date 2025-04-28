import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkDecoding {
  Future<Map<String, dynamic>> getInfo(String linkId) async {
    Map<String, dynamic> info = {};

    final response = await http.get(
      Uri.parse("https://linkbridge.chimeratechsolutions.com/link_info/$linkId"),
    );

    info = jsonDecode(response.body)['info'];

    return info;
  }
}
