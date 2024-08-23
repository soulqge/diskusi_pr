import 'package:hive/hive.dart';

class HiveBoxes {
  static Box getSavedDataBox() => Hive.box('savedDataBox');
}
