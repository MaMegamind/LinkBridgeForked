import 'package:link_bridge/link_decoding.dart';
import 'package:flutter/services.dart';

class DeepLink {
  static final String domainName = "https://apiv2.vooomapp.com";

  final MethodChannel _channel = const MethodChannel('deeplink_channel');

  Future<Uri?> init() async {
    try {
      String? initialLink = await _channel.invokeMethod<String>('onInitialLink');
      initialLink ??= await getInstallLink();

      if (initialLink != null) {
        initialLink = await decodeLink(initialLink);
      }
      return initialLink == null ? null : Uri.parse(initialLink);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getInstallLink() async {
    try {
      return await _channel.invokeMethod<String>('getInstallReferrer');
    } catch (e) {
      return null;
    }
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
    String decodedLink;

    String appName = link.replaceAll("$domainName/link/", "").split("/")[0];
    String encodedParameters =
        link.replaceAll("$domainName/link/", "").split("/")[1];

    Map<String, dynamic> decodedParameters = await LinkDecoding().getInfo(encodedParameters);

    decodedLink =
        "$domainName/link/$appName?${Uri(queryParameters: decodedParameters).query}";

    return decodedLink;
  }
}
