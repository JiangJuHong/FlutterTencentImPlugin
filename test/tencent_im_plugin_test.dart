import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('tencent_im_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TencentImPlugin.platformVersion, '42');
  });
}
