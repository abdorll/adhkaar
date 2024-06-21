import 'package:hive_flutter/hive_flutter.dart';
part 'adhkaar_model.g.dart';

@HiveType(typeId: 1)
class AdhkaarModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  @HiveField(2)
  int countMade;
  set setCount(value) => countMade = value;
  
  AdhkaarModel(
      {required this.title, required this.subtitle, required this.countMade});
}
