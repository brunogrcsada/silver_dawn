class Cities {
  int _cityID;
  String _name;

  Cities([this._name]);
  Cities.withId(this._cityID, [this._name]);

  int get cityID => _cityID;
  String get name => _name;

  set name(String cityName) {
    this._name = cityName;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (cityID != null) {
      map['city_id'] = _cityID;
    }
    map['name'] = _name;

    return map;
  }

  Cities.fromMapObject(Map<String, dynamic> map) {
    this._cityID = map['city_id'];
    this._name = map['name'];

  }

}