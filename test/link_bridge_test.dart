// import 'package:flutter_test/flutter_test.dart';
// import 'package:link_bridge/link_bridge.dart';
// import 'package:link_bridge/link_bridge_platform_interface.dart';
// import 'package:link_bridge/link_bridge_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockLinkBridgePlatform
//     with MockPlatformInterfaceMixin
//     implements LinkBridgePlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final LinkBridgePlatform initialPlatform = LinkBridgePlatform.instance;
//
//   test('$MethodChannelLinkBridge is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelLinkBridge>());
//   });
//
//   test('getPlatformVersion', () async {
//     LinkBridge linkBridgePlugin = LinkBridge();
//     MockLinkBridgePlatform fakePlatform = MockLinkBridgePlatform();
//     LinkBridgePlatform.instance = fakePlatform;
//
//     expect(await linkBridgePlugin.getPlatformVersion(), '42');
//   });
// }
