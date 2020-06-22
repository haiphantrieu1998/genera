import 'package:hive/hive.dart';

part 'recent_model.g.dart';

@HiveType(typeId: 1)
class RecentModel extends HiveObject{
  @HiveField(0)
  String time;
  @HiveField(1)
  String hashtag;

  RecentModel({this.time, this.hashtag});
}
