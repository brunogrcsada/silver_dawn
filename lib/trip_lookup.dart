class TripLookup{
  int _tripID;
  String _destinationName;
  String _driverFirstName;
  String _driverLastName;
  String _coachRegistration;
  String _date;
  int _duration;
  double _cost;

  TripLookup(this._destinationName, this._driverFirstName, this._driverLastName, this._coachRegistration, this._date, this._duration, this._cost);
  TripLookup.withId(this._tripID, this._destinationName, this._driverFirstName, this._driverLastName, this._coachRegistration, this._date, this._duration, this._cost);

  int get tripID => _tripID;
  String get destinationName => _destinationName;
  String get driverFirstName => _driverFirstName;
  String get driverLastName => _driverLastName;
  String get coachRegistration => _coachRegistration;
  String get date => _date;
  int get duration => _duration;
  double get cost => _cost;
  List get variableList => ["","","","","",""];

  set destinationName(String destinationIdentification){
    this._destinationName = destinationIdentification;
  }

  set driverFirstName(String driverNameFirst){
    this._driverFirstName = driverNameFirst;
  }

  set driverLastName(String driverNameLast){
    this._driverLastName = driverNameLast;
  }

  set coachRegistration(String coachIdentification){
    this._coachRegistration = coachIdentification;
  }

  set date(String tripDate){
    this._date = tripDate;
  }

  set duration(int tripDuration){
    this._duration = tripDuration;
  }

  set cost(double tripCost){
    this._cost = tripCost;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (tripID != null) {
      map['trip_id'] = _tripID;
    }
    map['name'] = _destinationName;
    map['first_name'] = _driverFirstName;
    map['last_name'] = _driverLastName;
    map['registration'] = _coachRegistration;
    map['date'] = _date;
    map['duration'] = _duration;
    map['cost'] = _cost;

    return map;
  }

  TripLookup.fromMapObject(Map<String, dynamic> map) {
    this._tripID = map['trip_id'];
    this._destinationName = map['name'];
    this._driverFirstName = map['first_name'];
    this._driverLastName = map['last_name'];
    this._coachRegistration = map['registration'];
    this._date = map['date'];
    this._duration = map['duration'];
    this._cost = map['cost'];

  }



}