import 'dart:convert';

import 'package:flutter/services.dart';

/// Class for decode link info
class LinkDecoding {
  /// decode link info function
  Future<Map<String, dynamic>?> getInfo(String linkId) async {
    /// The method channel used to communicate with platform-specific code.
    final MethodChannel _channel = const MethodChannel('deeplink_channel');

    /// Get link info by sending link id
    try {
      /// Get link info
      String? encodedResponse =
          await _channel.invokeMethod<String>('getLinkInfo', {
        'linkId': linkId,
      });

      /// If null return null. not, return decoded response body
      if (encodedResponse != null) {
        return jsonDecode(encodedResponse);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
