import 'dart:convert';
import 'package:http/http.dart' as http;

import 'link_bridge.dart';

class LinkDecoding {

  Future<Map<String, dynamic>> getInfo(String linkId) async {
    Map<String, dynamic> info = {};

    final response = await http.get(
      Uri.parse("${DeepLink.domainName}/link_info/$linkId"),
    );

    info = jsonDecode(response.body)['info'];

    return info;
  }
}
