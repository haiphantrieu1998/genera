class MenuHashtagDetailModel {
  //todo: trong detail gồm 3 thuộc tính chính
  final int id;
  final String name;
  final String content;
  MenuHashtagDetailModel({this.content,this.id, this.name});

  factory MenuHashtagDetailModel.fromJson(Map<String , dynamic> json){
    return MenuHashtagDetailModel(
      id: json['id'],
      name: json['name'],
      content: json['content']
    );
  }
}

class MenuHashtagDetailList {
  final List<MenuHashtagDetailModel> list;
  MenuHashtagDetailList({this.list});
  factory MenuHashtagDetailList.fromJson(List jsons){
    List<MenuHashtagDetailModel> list =[];
    list = jsons.map((e) => MenuHashtagDetailModel.fromJson(e)).toList();
    return MenuHashtagDetailList(list: list);
  }

}