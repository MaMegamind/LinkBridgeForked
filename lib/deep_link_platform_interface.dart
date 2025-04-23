// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// import 'deep_link_method_channel.dart';
//
// abstract class DeepLinkPlatform extends PlatformInterface {
//   /// Constructs a DeepLinkPlatform.
//   DeepLinkPlatform() : super(token: _token);
//
//   static final Object _token = Object();
//
//   static DeepLinkPlatform _instance = MethodChannelDeepLink();
//
//   /// The default instance of [DeepLinkPlatform] to use.
//   ///
//   /// Defaults to [MethodChannelDeepLink].
//   static DeepLinkPlatform get instance => _instance;
//
//   /// Platform-specific implementations should set this with their own
//   /// platform-specific class that extends [DeepLinkPlatform] when
//   /// they register themselves.
//   static set instance(DeepLinkPlatform instance) {
//     PlatformInterface.verifyToken(instance, _token);
//     _instance = instance;
//   }
//
//   Future<String?> getPlatformVersion() {
//     throw UnimplementedError('platformVersion() has not been implemented.');
//   }
// }
