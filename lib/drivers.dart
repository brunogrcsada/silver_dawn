class Destinations {
  int _destinationID;
  String _name;
  String _hotel;

  Destinations(this._name, [this._hotel]);
  Destinations.withId(this._destinationID, this._name, [this._hotel]);

  int get destinationID => _destinationID;
  String get name => _name;
  String get hotel => _hotel;
  List get variableList => ["", ""];


  set name(String destinationName) {
    if (destinationName.length <= 255) {
      this._name = destinationName;
    }
  }

  set hotel(String destinationHotel) {
    if (destinationHotel.length <= 255) {
      this._hotel = destinationHotel;
    }
  }


  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (destinationID != null) {
      map['destination_id'] = _destinationID;
    }
    map['name'] = _name;
    map['hotel'] = _hotel;

    return map;
  }

  Destinations.fromMapObject(Map<String, dynamic> map) {
    this._destinationID = map['destination_id'];
    this._name = map['name'];
    this._hotel = map['hotel'];

  }

}