class MenuHashtagModel {
  final int id;
  final String name;

  MenuHashtagModel({this.id, this.name});
//todo: map các thành viên lớp này vào đối tượng json
//todo: để làm được điều đó chúng ta cần tạo method factory.
//todo: use factory keyword when implementing a constructor that doesn’t always
//todo: create a new instance of its class and that’s what we need right now.1

  factory MenuHashtagModel.fromJson(Map<String , dynamic> json){
    return MenuHashtagModel(
      id: json['id'],
      name: json['name']
    );
  }
}
//todo: Here, we are creating a factory method called MenuHashtagModel.fromJson 
//todo: whose objective is to simply deserialize your json.
//todo: convert Object to Json 
class MenuHashtagList {
  final List<MenuHashtagModel> list;

  MenuHashtagList({this.list});
  
  factory MenuHashtagList.fromJson(List jsons){
    List<MenuHashtagModel> list =[];
    list = jsons.map((e) => MenuHashtagModel.fromJson(e)).toList();
    return MenuHashtagList(list: list);
  }

}