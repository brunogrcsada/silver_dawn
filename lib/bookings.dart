class Bookings {
  int _bookingID;
  int _customerID;
  int _tripID;
  String _date;
  int _passengerNumber;
  String _requirements;

  Bookings(this._customerID, this._tripID, this._date, this._passengerNumber, [this._requirements]);
  Bookings.withId(this._bookingID, this._customerID, this._tripID, this._date, this._passengerNumber, [this._requirements]);

  int get bookingID => _bookingID;
  int get customerID => _customerID;
  int get tripID => _tripID;
  String get date => _date;
  int get passengerNumber => _passengerNumber;
  List get variableList => ["", "", "", ""];


  set customerID(int customerIdentification) {
      this._customerID = customerIdentification;
  }

  set tripID(int tripIdentification) {
      this._tripID = tripIdentification;
  }

  set date(String currentDate){
      this._date = currentDate;
  }

  set passengerNumber(int bookingNumber) {
      this._passengerNumber = bookingNumber;
  }

  set requirements(String customerRequirements) {
    if (customerRequirements.length <= 255) {
      this._requirements = customerRequirements;
    }
  }


  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (bookingID != null) {
      map['booking_id'] = _bookingID;
    }
    map['customer_id'] = _customerID;
    map['trip_id'] = _tripID;
    map['date'] = _date;
    map["passenger_number"] = _passengerNumber;
    map['requests'] = _requirements;

    return map;
  }

  Bookings.fromMapObject(Map<String, dynamic> map) {
    this._bookingID = map['booking_id'];
    this._customerID = map['customer_id'];
    this._tripID = map['trip_id'];
    this._date = map['date'];
    this._passengerNumber = map['passenger_number'];
    this._requirements = map['requests'];

  }

}