// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/network_tools.dart';

void main() {
  group(
      'Uri.toString() method test - This method is often used in the project, so be sure to validate it. Should return a URL of the form schema + domain / ipaddress + port',
      () {
    test('Method working with domains in different schemas', () async {
      expect(
        Uri.parse('https://test-rpc.kira.network/').toString(),
        'https://test-rpc.kira.network/',
      );

      expect(
        Uri.parse('http://test-rpc.kira.network/').toString(),
        'http://test-rpc.kira.network/',
      );
    });

    test('Method working with ip in different schemas', () async {
      expect(
        Uri.parse('http://192.168.0.1/').toString(),
        'http://192.168.0.1/',
      );

      expect(
        Uri.parse('https://192.168.0.1/').toString(),
        'https://192.168.0.1/',
      );
    });

    test('Method working with ports', () async {
      expect(
        Uri.parse('http://192.168.0.1:8001/').toString(),
        'http://192.168.0.1:8001/',
      );

      expect(
        Uri.parse('https://192.168.0.1:8001/').toString(),
        'https://192.168.0.1:8001/',
      );
    });
  });

  group(
      'parseUri - Method based on parseStringToCorrectUri. Should parse Uri to required format. If host is ip address and port is undefined, method should add default port 11000 to Uri',
      () {
    test('Method working with different schemas', () async {
      expect(
        NetworkTools.parseUrl('https://test-rpc.kira.network').toString(),
        'https://test-rpc.kira.network',
      );

      expect(
        NetworkTools.parseUrl('http://test-rpc.kira.network').toString(),
        'http://test-rpc.kira.network',
      );

      expect(
        NetworkTools.parseUrl('https://192.168.0.1').toString(),
        'https://192.168.0.1:11000',
      );

      expect(
        NetworkTools.parseUrl('http://192.168.0.1').toString(),
        'http://192.168.0.1:11000',
      );
    });

    test('Method working with bad uri', () async {
      expect(
        NetworkTools.parseUrl('192.168.0.1').toString(),
        'http://192.168.0.1:11000',
      );

      expect(
        NetworkTools.parseUrl('192.168.0.1:80').toString(),
        'http://192.168.0.1:11000',
      );

      expect(
        NetworkTools.parseUrl('192.168.0.1:443').toString(),
        'http://192.168.0.1:11000',
      );
    });

    test('Method working with ports', () async {
      expect(
        NetworkTools.parseUrl('https://192.168.0.1:8080').toString(),
        'https://192.168.0.1:8080',
      );

      expect(
        NetworkTools.parseUrl('http://192.168.0.1:8080').toString(),
        'http://192.168.0.1:8080',
      );

      expect(
        NetworkTools.parseUrl('192.168.0.1:8080').toString(),
        'http://192.168.0.1:8080',
      );
    });

    test('Method working with query params', () async {
      expect(
        NetworkTools.parseUrl('https://192.168.0.1:8080?test1=result1&test2=result2').toString(),
        'https://192.168.0.1:8080?test1=result1&test2=result2',
      );

      expect(
        NetworkTools.parseUrl('https://testnet.kira.network?test1=result1&test2=result2').toString(),
        'https://testnet.kira.network?test1=result1&test2=result2',
      );

      expect(
        NetworkTools.parseUrl('192.168.0.1:8080?test1=result1&test2=result2').toString(),
        'http://192.168.0.1:8080?test1=result1&test2=result2',
      );
    });
  });
}
