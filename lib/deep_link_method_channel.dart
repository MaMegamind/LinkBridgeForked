// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
//
// import 'deep_link_platform_interface.dart';
//
// /// An implementation of [DeepLinkPlatform] that uses method channels.
// class MethodChannelDeepLink extends DeepLinkPlatform {
//   /// The method channel used to interact with the native platform.
//   @visibleForTesting
//   final methodChannel = const MethodChannel('deep_link');
//
//   @override
//   Future<String?> getPlatformVersion() async {
//     final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
//     return version;
//   }
// }
