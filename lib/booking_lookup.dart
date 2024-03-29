class BookingLookup{
  int _bookingID;
  int _tripID;
  String _firstName;
  String _lastName;
  String _address;
  String _address2;
  String _town;
  String _postCode;
  String _email;
  String _phoneNumber;
  String _requirements;
  int _passengers;

  BookingLookup(this._tripID, this._firstName, this._lastName, this._address,
      this._address2, this._town, this._postCode, this._email, this._phoneNumber,
      this._requirements, [this._passengers]);
  BookingLookup.withId(this._bookingID, this._tripID, this._firstName, this._lastName,
      this._address, this._address2, this._town, this._postCode, this._email,
      this._phoneNumber, this._requirements, [this._passengers]);

  int get bookingID => _bookingID;
  int get tripID => _tripID;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get address => _address;
  String get address2 => _address2;
  String get town => _town;
  String get postCode => _postCode;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get requirements => _requirements;
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

  set address(String customerAddress) {
    if (customerAddress.length <= 255) {
      this._address = customerAddress;
    }
  }

  set address2(String customerAddress2) {
    if (customerAddress2.length <= 255) {
      this._address2 = customerAddress2;
    }
  }

  set town(String customerTown) {
    this._town = customerTown;
  }

  set postCode(String customerPostCode) {
    if (customerPostCode.length <= 255) {
      this._postCode = customerPostCode;
    }
  }

  set email(String customerEmail) {
    if (customerEmail.length <= 255) {
      this._email = customerEmail;
    }
  }

  set phoneNumber(String customerPhoneNumber) {
    if (customerPhoneNumber.length <= 255) {
      this._phoneNumber = customerPhoneNumber;
    }
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
    map['trip_id'] = _tripID;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address_1'] = _address;
    map['address_2'] = _address2;
    map['name'] = _town;
    map['post_code'] = _postCode;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['requirements'] = _requirements;
    map['passenger_number'] = _passengers;

    return map;
  }

  BookingLookup.fromMapObject(Map<String, dynamic> map) {
    this._bookingID = map['booking_id'];
    this._tripID = map['trip_id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._address = map['address_1'];
    this._address2 = map['address_2'];
    this._town = map['name'];
    this._postCode = map['post_code'];
    this._email = map['email'];
    this._phoneNumber = map['phone_number'];
    this._requirements = map['requirements'];
    this._passengers = map['passenger_number'];

  }
}