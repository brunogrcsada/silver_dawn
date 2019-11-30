class BookingLookup{
  int _bookingID;
  int _tripID;
  String _firstName;
  String _lastName;
  int _passengers;

  BookingLookup(this._tripID, this._firstName, this._lastName, [this._passengers]);
  BookingLookup.withId(this._bookingID, this._tripID, this._firstName, this._lastName, [this._passengers]);

  int get bookingID => _bookingID;
  int get tripID => _tripID;
  String get firstName => _firstName;
  String get lastName => _lastName;
  int get passengers => _passengers;

  set tripID(int bookingTripID){
    this._tripID = bookingTripID;
  }

  set firstName(String customerFirstName){
    this._firstName = customerFirstName;
  }

  set lastName(String customerLastName){
    this._lastName = customerLastName;
  }

  set passengers(int passengerNumber){
    this._passengers = passengerNumber;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (bookingID != null) {
      map['booking_id'] = _bookingID;
    }
    map['trip_id'] = _tripID;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['passenger_number'] = _passengers;

    return map;
  }

  BookingLookup.fromMapObject(Map<String, dynamic> map) {
    this._bookingID = map['booking_id'];
    this._tripID = map['trip_id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._passengers = map['passenger_number'];

  }
}