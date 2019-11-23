class TripLookup{
  int _tripID;
  String _destinationID;
  int _driverID;
  int _coachID;
  String _date;
  double _duration;
  double _cost;

  TripLookup(this._destinationID, this._driverID, this._coachID, this._date, this._duration, this._cost);
  TripLookup.withId(this._tripID, this._destinationID, this._driverID, this._coachID, this._date, this._duration, this._cost);

  int get tripID => _tripID;
  String get destinationID => _destinationID;
  int get driverID => _driverID;
  int get coachID => _coachID;
  String get date => _date; //TODO: Convert to date object.
  double get duration => _duration;
  double get cost => _cost;
  List get variableList => ["","","","","",""];

  set destinationID(String destinationIdentification){
    this._destinationID = destinationIdentification;
  }

  set driverID(int driverIdentification){
    this._driverID = driverIdentification;
  }

  set coachID(int coachIdentification){
    this._coachID = coachIdentification;
  }

  set date(String tripDate){
    this._date = tripDate;
  }

  set duration(double tripDuration){
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
    map['name'] = _destinationID;
    map['driver_id'] = _driverID;
    map['coach_id'] = _coachID;
    map['date'] = _date;
    map['duration'] = _duration;
    map['cost'] = _coachID;

    return map;
  }

  TripLookup.fromMapObject(Map<String, dynamic> map) {
    this._tripID = map['trip_id'];
    this._destinationID = map['name'];
    this._driverID = map['driver_id'];
    this._coachID = map['coach_id'];
    this._date = map['date'];
    this._duration = map['duration'];
    this._cost = map['cost'];

  }



}