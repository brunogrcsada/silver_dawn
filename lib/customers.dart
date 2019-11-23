class Customers {
  int _customerID;
  String _firstName;
  String _lastName;
  String _address;
  String _address2;
  String _town;
  String _postCode;
  String _email;
  String _phoneNumber;
  String _requirements;

  Customers(this._firstName, this._lastName, this._address, this._address2, this._town, this._postCode, this._email, this._phoneNumber, [this._requirements] );
  Customers.withId(this._customerID, this._firstName, this._lastName, this._address, this._address2, this._town, this._postCode, this._email, this._phoneNumber, [this._requirements]);

  int get customerID => _customerID;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get address => _address;
  String get address2 => _address2;
  String get town => _town;
  String get postCode => _postCode;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get requirements => _requirements;
  List get variableList => ["", "", "", "", "", "", "", "", ""];


  set firstName(String customerFirstName) {
    if (customerFirstName.length <= 255) {
      this._firstName = customerFirstName;
    }
  }

  set lastName(String customerLastName) {
    if (customerLastName.length <= 255) {
      this._lastName = customerLastName;
    }
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
      this._town = town;
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
    if (customerID != null) {
      map['customer_id'] = _customerID;
    }
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address_1'] = _address;
    map['address_2'] = _address2;
    map['city'] = _town;
    map['post_code'] = _postCode;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['requirements'] = _requirements;

    return map;
  }

  Customers.fromMapObject(Map<String, dynamic> map) {
    this._customerID = map['customer_id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._address = map['address_1'];
    this._address2 = map['address_2'];
    this._town = map['city'];
    this._postCode = map['post_code'];
    this._email = map['email'];
    this._phoneNumber = map['phone_number'];
    this._requirements = map['requirements'];

  }

}