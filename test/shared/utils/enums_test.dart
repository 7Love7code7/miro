import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/enums.dart';

enum TestEnum {
  firstTest,
  secondTest,
}

void main() {
  group('EnumsTest', () {
    test('enumToString - method should rename enum.toString() (TestEnum.firstTest) to enum name only (firstTest)',
        () async {
      expect(enumToString(TestEnum.firstTest), 'firstTest');

      expect(enumToString(TestEnum.secondTest), 'secondTest');
    });

    test('enumFromString - method should find correct enum from enum string', () async {
      expect(enumFromString(TestEnum.values, 'firstTest'), TestEnum.firstTest);

      expect(enumFromString(TestEnum.values, 'secondTest'), TestEnum.secondTest);
    });
  });
}
