class Drivers {
  int _driverID;
  String _firstName;
  String _lastName;

  Drivers(this._firstName, [this._lastName]);
  Drivers.withId(this._driverID, this._firstName, [this._lastName]);

  int get driverID => _driverID;
  String get firstName => _firstName;
  String get lastName => _lastName;
  List get variableList => ["", ""];


  set firstName(String driverFirstName) {
    if (driverFirstName.length <= 50) {
      this._firstName = driverFirstName;
    }
  }

  set hotel(String driverLastName) {
    if (driverLastName.length <= 50) {
      this._lastName = driverLastName;
    }
  }


  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (driverID != null) {
      map['driver_id'] = _driverID;
    }
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;

    return map;
  }

  Drivers.fromMapObject(Map<String, dynamic> map) {
    this._driverID = map['driver_id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];

  }

}