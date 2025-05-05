import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'package:flutter/services.dart';
import 'package:link_bridge/link_decoding.dart';

/// A bridge class to handle deep link decoding and install link resolution.
class LinkBridge {
  /// The method channel used to communicate with platform-specific code.
  final MethodChannel _channel = const MethodChannel('deeplink_channel');

  /// A function to fetch deeplink once
  Future<Uri?> init() async {
    try {
      String? initialLink =
          await _channel.invokeMethod<String>('onInitialLink');

      /// Check platform to get install link
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        initialLink ??= await getInstallLinkAndroid();
      } else if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
        initialLink ??= await getInstallLinkIos();
      }

      /// Decode deeplink
      if (initialLink != null) {
        initialLink = await decodeLink(initialLink);
      }
      return initialLink == null ? null : Uri.parse(initialLink);
    } catch (e) {
      return null;
    }
  }

  /// A function to fetch deeplink after installing for Android
  Future<String?> getInstallLinkAndroid() async {
    try {
      return await _channel.invokeMethod<String>('getInstallReferrer');
    } catch (e) {
      return null;
    }
  }

  /// A function to fetch deeplink after installing for IOS
  Future<String?> getInstallLinkIos() async {
    String? link;
    try {
      ClipboardData? clipboardData = await Clipboard.getData('text/plain');
      if (clipboardData != null) {
        link = clipboardData.text;
        await Clipboard.setData(ClipboardData(text: ""));
      }
    } catch (_) {}
    return link;
  }

  /// A function to fetch deeplink on opening the link
  Future<void> listen(Function(Uri? link) onLinkReceived) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onLinkReceived') {
        final link = call.arguments as String?;
        if (link != null) {
          String? decodedLink = await decodeLink(link);
          onLinkReceived(decodedLink == null ? null : Uri.parse(decodedLink));
        }
      }
    });
  }

  /// A function to decode link info
  Future<String?> decodeLink(String link) async {
    String linkCode = link.split("/")[4];
    String mainLink = link.replaceAll("/$linkCode", "");

    /// Decode Link
    Map<String, dynamic>? parameters;
    try {
      parameters = (await LinkDecoding().getInfo(linkCode))?['info'];
    } catch (_) {
      parameters = null;
    }

    /// Get link info by link id
    return parameters == null
        ? null
        : "$mainLink?${Uri(queryParameters: parameters).query}";
  }
}
