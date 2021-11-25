import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/password_utils.dart';

void main() {
  group('password_utils_test', () {
    test('fillToLength', () async {
      String testedPassword = 'kiraTest123';
      expect(
        PasswordUtils.fillToLength(text: testedPassword, length: 64),
        '00000000000000000000000000000000000000000000000000000kiraTest123',
      );
    });
  });
}
