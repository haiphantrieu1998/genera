
import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String content;

  FavoriteModel({this.title, this.name, this.content});
}
