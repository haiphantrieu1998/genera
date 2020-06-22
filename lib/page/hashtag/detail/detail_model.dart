class DetailModel {
  final int id;
  final String name;
  final String category;
  final String tags;

  DetailModel({this.id, this.name, this.category, this.tags});

  factory DetailModel.fromJson(Map<String , dynamic> json){
    return DetailModel(
      id: json['ID'],
      name: json['NAME'],
      category: json['CATEGORY'],
      tags: json['TAGS'],

    );
  }
}

