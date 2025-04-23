import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('deeplink_channel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Mock the method channel to simulate the response using the new approach
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'onInitialLink') {
        return 'https://example.com'; // Simulate a link
      }
      return null;
    });
  });

  test('Test onInitialLink method', () async {
    // Call the method and check the response
    final String? initialLink = await channel.invokeMethod<String>('onInitialLink');

    // Verify that the response is as expected
    expect(initialLink, 'https://example.com');
  });
}
