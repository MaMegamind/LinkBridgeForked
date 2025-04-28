import 'dart:io';

import 'package:flutter/services.dart';
import 'package:link_bridge/link_decoding.dart';

class LinkBridge {

  final MethodChannel _channel = const MethodChannel('deeplink_channel');

  Future<Uri?> init() async {
    try {
      String? initialLink =
          await _channel.invokeMethod<String>('onInitialLink');

      if (Platform.isAndroid) {
        initialLink ??= await getInstallLinkAndroid();
      } else if (Platform.isIOS) {
        initialLink ??= await getInstallLinkIos();
      }

      if (initialLink != null) {
        initialLink = await decodeLink(initialLink);
      }
      return initialLink == null ? null : Uri.parse(initialLink);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getInstallLinkAndroid() async {
    try {
      return await _channel.invokeMethod<String>('getInstallReferrer');
    } catch (e) {
      return null;
    }
  }

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

  Future<void> listen(Function(Uri link) onLinkReceived) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onLinkReceived') {
        final link = call.arguments as String?;
        if (link != null) {
          onLinkReceived(Uri.parse(await decodeLink(link)));
        }
      }
    });
  }

  Future<String> decodeLink(String link) async {
    String linkCode = link.split("/")[4];
    String mainLink = link.replaceAll("/$linkCode", "");

    Map<String, dynamic> decodedParameters = await LinkDecoding().getInfo(linkCode);

    String decodedLink = "$mainLink?${Uri(queryParameters: decodedParameters).query}";

    return decodedLink;
  }
}
