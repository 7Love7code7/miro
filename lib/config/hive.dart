import 'package:hive/hive.dart';

Future<void> initHive() async {
  await Hive.openBox<String>('configuration');
}
