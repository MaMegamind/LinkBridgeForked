import 'dart:convert';

import 'package:http/http.dart' as http;

/// Class for decode link info
class LinkDecoding {
  /// decode link info function
  Future<Map<String, dynamic>> getInfo(String linkId) async {
    /// Get link info by sending link id
    return jsonDecode((await http.get(
      Uri.parse(
          "https://linkbridge.chimeratechsolutions.com/link_info/$linkId"),
    ))
        .body)['info'];
  }
}
