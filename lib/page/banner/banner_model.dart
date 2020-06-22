class BannerModel {
  final int id;
  final String name;
  final String content;

  BannerModel({this.id, this.name, this.content});

  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
      id: json['id'],
      name: json['name'],
      content: json['content'],
    );
  }
}

class BannerModelList {
  final List<BannerModel> list;
  BannerModelList({this.list});
  factory BannerModelList.fromJson(List jsons){
    List<BannerModel> list =[];
    list = jsons.map((e) => BannerModel.fromJson(e)).toList();
    return BannerModelList(list: list);
  }

}