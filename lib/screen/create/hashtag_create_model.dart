class HashTag {
  int _id;
  String _name;

  HashTag(this._name);
  HashTag.withId(this._id, this._name);

  int get id => _id;
  String get name => _name;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    return map;
  }

  HashTag.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
  }
}
